require 'active_support/concern'
module NotificationHelper
	extend ActiveSupport::Concern
	def self.comment_notification(user , followed , followed_type , link)
		n = Notification.new(:notifier_id => user , :target_id => followed , :target_type => followed_type)
		useri = User.find(user)
		n.body = '<h3 style="text-align: center">'+ useri.last_name + ' commented on your ' + link +'</h3>'
		n.save
	end

	def self.followed_notification(user , followed ,followed_type)
		n = Notification.new(:notifier_id => user , :target_id => followed , :target_type => followed_type)
		useri = User.find(user)
		n.body = '<h3 style="text-align: center">'+ useri.last_name + ' followed you!</h3>'
		n.save
	end

	def self.unfollowed_notification(user , followed ,followed_type)
		n = Notification.new(:notifier_id => user, :target_id => followed , :target_type => followed_type)
		useri = User.find(user)
		n.body = '<h3 style="text-align: center">'+useri.last_name + ' unfollowed you!</h3>'
		n.save
	end

	def self.like_notification(notifier_id , target_id , target_type , link)
		n = Notification.new(:notifier_id => notifier_id, :target_id => target_id , :target_type => target_type)
		useri = User.find(notifier_id)
		n.body = '<h3 style="text-align: center">'+ useri.last_name + ' liked your ' + link +'</h3>'
		n.save
	end

	def self.dislike_notification(notifier_id , target_id , target_type , link)
		n = Notification.new(:notifier_id => notifier_id, :target_id => target_id , :target_type => target_type)
		useri = User.find(notifier_id)
		n.body = '<h3 style="text-align: center">'+ useri.last_name + ' disliked your ' + link +'</h3>'
		n.save
	end

	def self.post_notification(notifier_id , target_id)

	end

	def self.review_notification(notifier_id , target_id , target_type , link )
		n = Notification.new(:notifier_id => notifier_id, :target_id => target_id , :target_type => target_type)
		useri = User.find(notifier_id)
		n.body = '<h3 style="text-align: center">'+ useri.last_name + " reviewed on " + link +'</h3>'
		n.save
	end

	def self.report_notification(notifier_id , target_id , target_type , link)
		case target_type
		when 'Comment'
			comment = Comment.find(target_id)
			commentable = comment.commentable_type
			if commentable == 'Post'
				target_id = comment.commentable.user_id
				target_type = 'User'
			else
				if commentable == 'Review'
					target_id = comment.commentable.reviewable_id
					target_type = comment.commentable.reviewable_type
				end
			end
		when 'Post'
			post = Post.find(target_id)
			target_id = post.user_id
			target_type = 'User'
		when 'FoodItem'
			food = FoodItem.find(target_id)
			target_id = food.menu.restaurant_id
			target_type = 'Restaurant'
		end
		n = Notification.new(:notifier_id => notifier_id, :target_id => target_id , :target_type => target_type)
		useri = User.find(notifier_id)
		n.body = '<h3 style="text-align: center">'+ useri.last_name + " reported your " + link +'</h3>'
		n.save
	end
end
