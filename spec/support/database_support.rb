gem 'byebug'


require "rubygems"
gem 'activerecord'
 
require 'active_record'
 
ActiveRecord::Base.establish_connection(adapter: 'sqlite3', database: ':memory:')
 
ActiveRecord::Schema.define do
  create_table :posts do |t|
    t.string :title
    t.text :article
  end
 
  create_table :comments do |t|
    t.integer :post_id
    t.text :comment
  end

  create_table :authors do |t|
    t.text :name
  end

  create_table :authors_posts do |t|
    t.integer :author_id
    t.integer :post_id
  end
  
end
 
class Post < ActiveRecord::Base
  has_many :comments, autosave: :true
  has_and_belongs_to_many :authors
end
 
class Comment < ActiveRecord::Base
  belongs_to :post
  belongs_to :jaca, class_name: 'Post'
end

class Author < ActiveRecord::Base
  has_and_belongs_to_many :posts
end
