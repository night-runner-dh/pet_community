class Post < ApplicationRecord
belongs_to :user
has_many :favorites, dependent: :destroy
has_many :post_comments, dependent: :destroy
has_many :tags, dependent: :destroy
has_one_attached :image

 validates :title, presence: true
 validates :body, presence: true

 def favorited?(user)
   if user.nil?
     # ログインしていない場合の表示を設定する（例：「ログインしていません」と表示する）
     "ログインしていません"
   else
     favorites.where(user_id: user.id).exists?
   end
 end


# 検索方法分岐　一応完全一致や前半後半一致なども
  def self.looks(search, word)
    #if search == "perfect_match"
     # @post = Post.where("title LIKE?","#{word}")
    #elsif search == "forward_match"
      #@post = Post.where("title LIKE?","#{word}%")
    #elsif search == "backward_match"
      #@post = Post.where("title LIKE?","%#{word}")
    #if search == "partial_match"
      @post = Post.where("title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%")
    #else
      #@post = Post.all
    #end
  end



end
