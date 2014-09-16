FactoryGirl.define do
  factory :author do
    sequence(:name) {|n| "name #{n}" }
  end

end