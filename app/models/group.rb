class Group < ApplicationRecord
  has_many :group_users, dependent: :destroy
  belongs_to :owner, class_name: "User"
  has_many :users, through: :group_users, source: :user
  has_many :group_comments, dependent: :destroy
  has_many :permits, dependent: :destroy

  validates :name, presence: true
  validates :introduction, presence: true
  has_one_attached :group_image

  #def get_group_image
   # (group_image.attached?) ? group_image : 'no_image.jpg'
  #end
  
  # 検索方法分岐
  def self.looks(search, word)
    #if search == "perfect_match"
     # @post = Post.where("title LIKE?","#{word}")
    #elsif search == "forward_match"
      #@post = Post.where("title LIKE?","#{word}%")
    #elsif search == "backward_match"
      #@post = Post.where("title LIKE?","%#{word}")
    if search == "partial_match"
      @group = Group.where("title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%")
    else
      @group = Group.all
    end
  end

  
  
  
  

  def is_owned_by?(user)
    owner.id == user.id
  end
  
  def include_user?(user)
    group_users.exists?(user_id: user.id)
  end
end
