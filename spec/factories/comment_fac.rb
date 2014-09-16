FactoryGirl.define do
  factory :comment do
    sequence(:comment) {|n| "comment #{n}" }
  end

end