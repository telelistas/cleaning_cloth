require 'spec_helper'

describe "" do
  # include Support::Database

  subject { create(:post) }

  context "before cleaning cloth" do
    it { subject.title.should_not be_empty }
  end

  context "after cleaning cloth" do
    before { subject.clean! }
    it { subject.title.should be_empty }
  end
end