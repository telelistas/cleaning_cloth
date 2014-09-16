FactoryGirl.define do
  factory :post do
    sequence(:title) {|n| "title #{n}" }
    sequence(:article) {|n| "article #{n}" }
    authors { [create(:author), create(:author)]}
    comments { [create(:comment), create(:comment)]}
  end

end