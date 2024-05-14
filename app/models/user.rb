class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #バリデーション、新規登録時は名前とアドレスのみなので二つのみ
  validates :name, presence: true
  #validates :email, presence: true
  
  has_many :posts, dependent: :destroy
  has_many :post_comments, dependent: :destroy
  #has_many :favorites, dependent: :destroy

  #has_many :active_relationships, class_name: "Relationship", foreign_key: "follower_id", dependent: :destroy
  # フォローされている関連付け
  #has_many :passive_relationships, class_name: "Relationship", foreign_key: "followed_id", dependent: :destroy
  # フォローしているユーザーを取得
  #has_many :followings, through: :active_relationships, source: :followed
  # フォロワーを取得
  #has_many :followers, through: :passive_relationships, source: :follower
  
  # 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @user = User.where("name LIKE?", "#{word}")
      #今回前方一致、後方一致の検索方法は採用しない為
    #elsif search == "forward_match"
      #@user = User.where("name LIKE?","#{word}%")
    #elsif search == "backward_match"
      #@user = User.where("name LIKE?","%#{word}")
    elsif search == "partial_match"
      @user = User.where("name LIKE?","%#{word}%")
    else
      @user = User.all
    end
  end
  
  
  
end
