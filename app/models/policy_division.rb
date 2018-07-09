class PolicyDivision < ApplicationRecord
  belongs_to :policy
  belongs_to :division
  has_paper_trail
  validates :division_id, presence: true, uniqueness:  { scope: :policy_id}
  after_create :create_person_distanse
  def create_person_distanse
    not_agre = ["absent","abstain", "not_voted"]
    if self.support == "aye_strong"
      possible = 50
      support = "aye"
      assume_agre = 50
      assume_against = 0
      assume_no_agre = 25
    elsif self.support = "against_strong"
      possible = 50
      support = "against"
      assume_agre = 50
      assume_against = 0
      assume_no_agre = 25
    else
      possible = 10
      support = self.support
      assume_agre = 10
      assume_against = 0
      assume_no_agre = 5
    end
    self.division.votes.each do |v|
      p v.vote
      policy_persone_distanse = PolicyPersonDistance.where(deputy_id: v.mp.deputy_id, policy_id: self.policy_id).first_or_create
      if support == v.vote
         assume = assume_agre
         policy_persone_distanse.assume = policy_persone_distanse.assume + assume
         policy_persone_distanse.possible = policy_persone_distanse.possible + possible
         policy_persone_distanse.support = (policy_persone_distanse.assume.to_f/policy_persone_distanse.possible) * 100
         policy_persone_distanse.save
      elsif not_agre.include?(v.vote)
         assume = assume_no_agre
         policy_persone_distanse.assume = policy_persone_distanse.assume + assume
         policy_persone_distanse.possible = policy_persone_distanse.possible + possible
         policy_persone_distanse.support = (policy_persone_distanse.assume.to_f/policy_persone_distanse.possible) * 100
         policy_persone_distanse.save
      else
         assume = assume_against
         policy_persone_distanse.assume = policy_persone_distanse.assume + assume
         policy_persone_distanse.possible = policy_persone_distanse.possible + possible
         policy_persone_distanse.support = (policy_persone_distanse.assume.to_f/policy_persone_distanse.possible) * 100
         policy_persone_distanse.save
      end
    end
  end
end
