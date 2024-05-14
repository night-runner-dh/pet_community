class Post < ApplicationRecord
belongs_to :user

has_one_attached :image

 validates :title, presence: true
 validates :body, presence: true

# 検索方法分岐
  def self.looks(search, word)
    if search == "perfect_match"
      @post = Post.where("title LIKE?","#{word}")
    #elsif search == "forward_match"
      #@post = Post.where("title LIKE?","#{word}%")
    #elsif search == "backward_match"
      #@post = Post.where("title LIKE?","%#{word}")
    elsif search == "partial_match"
      @post = Post.where("title LIKE ? OR body LIKE ?", "%#{word}%", "%#{word}%")
    else
      @post = Post.all
    end
  end



end
