class PagesController < ApplicationController
    
    def homepage
        per_page = 50
        if current_user.nil? == false
            @newPost = Post.new()
            user_and_follower_id = [current_user.id] + current_user.following_ids
            @posts = Post.where(:user_id => user_and_follower_id).limit(per_page)
        end
    end
    
end
