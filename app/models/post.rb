class Post < ActiveRecord::Base
	attr_accessible :user_id, :title, :content

	belongs_to :user
end
