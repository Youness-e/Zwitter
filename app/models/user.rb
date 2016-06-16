class User < ActiveRecord::Base
    # Include default devise modules. Others available are:
    # :confirmable, :lockable, :timeoutable and :omniauthable
    devise :database_authenticatable, :registerable,
      :recoverable, :rememberable, :trackable, :validatable
    
    has_many :relations, :class_name => "Relationship", :foreign_key => "follower_id", :dependent => :destroy
    has_many :passive_relations, :class_name => "Relationship", :foreign_key => "followed_id", :dependent => :destroy
    has_many :following, :through => :relations, :source => :followed
    has_many :followers, :through => :relations, :source => :follower
    has_many :posts
    
    has_attached_file :picture, styles: { medium: "300x300>", thumb: "150x150>" }, default_url: "/images/users/:style/missing.png"
    validates_attachment_content_type :picture, content_type: /\Aimage\/.*\Z/
    
    # Follow a user
    def follow(o_user)
        relations.create(:followed_id => o_user.id)
    end
    # unfollow a user
    def unfollow(o_user)
        relations.find_by(:followed_id => o_user.id).destroy()
    end
    # is following a user 
    def following?(o_user)
        return following.include(o_user)
    end
end
