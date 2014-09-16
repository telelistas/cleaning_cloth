require 'spec_helper'

describe "cleaning_cloth" do

  subject { create(:post) }

  let(:comment) { subject.comments.first }
  let(:author) { subject.authors.first }

  context "before cleaning cloth" do
    it { subject.id.should be_present }
    it { subject.title.should be_present }

    it { comment.id.should be_present }
    it { comment.comment.should be_present }
    it { comment.post_id.should be_present }

    it { author.id.should be_present }
    it { author.name.should be_present }
    it { author.should be_present }

  end

  context "after cleaning cloth" do
    subject { @post = create(:post); @post.clean!; @post.save!; @post }

    it { subject.id.should be_present }
    it { subject.title.should be_nil }

    it { comment.id.should be_present }
    it { comment.comment.should be_nil }
    it { comment.post_id.should be_present }

    it { author.id.should be_present }
    it { author.name.should be_nil }
    it { author.should be_present }


    context "with exceptions params" do

        subject { @post = create(:post).clean!({ except: :title, comments: { except: :comment } }); @post.save!; @post }
  
        it { subject.id.should be_present }
        it { subject.title.should be_present }
  
        it { comment.id.should be_present }
        it { comment.comment.should be_present }
        it { comment.post_id.should be_present }
  
        it { author.id.should be_present }
        it { author.name.should be_nil }
        it { author.should be_present }
  
    end
    context "with default clean options" do

        subject { 
          @post = create(:post)
          def @post.default_clean_options
            { except: :title, comments: { except: :comment } }
          end
          @post.clean! 
          @post.save!
          @post
        }
  
        it { subject.id.should be_present }
        it { subject.title.should be_present }
  
        it { comment.id.should be_present }
        it { comment.comment.should be_present }
        it { comment.post_id.should be_present }

        it { author.id.should be_present }
        it { author.name.should be_nil }
        it { author.should be_present }
  
    end

  end
end