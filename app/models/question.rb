# == Schema Information
#
# Table name: questions
#
#  id         :bigint           not null, primary key
#  title      :string(255)      not null
#  body       :text(65535)      not null
#  user_id    :bigint
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Question < ApplicationRecord
  belongs_to :user
  has_many   :answers, dependent: :destroy
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :votes,    as: :votable, dependent: :destroy

  validates :title, presence: true

  validates :body, presence: true

  scope :order_by_newest, -> { order("id desc") }

  def voted_by?(user)
    votes.exists?(user: user)
  end
end
