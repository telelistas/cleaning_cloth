require 'spec_helper'

describe "" do
  # include Support::Database

  subject { create(:post) }

  let(:comment) { subject.comments.first }
  let(:author) { subject.authors.first }

  context "before cleaning cloth" do
    it { subject.id.should be_present }
    it { subject.title.should be_present }

    it { comment.id.should be_present }
    it { comment.comment.should be_present }

    it { author.id.should be_present }
    it { author.name.should be_present }

  end

  context "after cleaning cloth" do
    before { subject.clean! }

    it { subject.id.should be_present }
    it { subject.title.should be_nil }

    it { comment.id.should be_present }
    it { comment.comment.should be_nil }

    it { author.id.should be_present }
    it { author.name.should be_nil }

  end
end