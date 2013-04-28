class Post < ActiveRecord::Base
	attr_accessible :user_id, :title, :content

	belongs_to :user

	def is_owned?(u)
		self.user.id == u.id
	end
end
