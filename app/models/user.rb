class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
         
  #バリデーション、新規登録時は名前とアドレスのみなので二つのみ
  validates :name, presence: true
  #validates :email, presence: true
  
end
