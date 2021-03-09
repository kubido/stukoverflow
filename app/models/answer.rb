# == Schema Information
#
# Table name: answers
#
#  id          :bigint           not null, primary key
#  body        :text(65535)
#  question_id :bigint
#  user_id     :bigint
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Answer < ApplicationRecord
  belongs_to :question
  belongs_to :user
  has_many   :comments, as: :commentable, dependent: :destroy
  has_many   :votes,    as: :votable, dependent: :destroy

  validates :body, presence: true

  scope :order_by_newest, -> { order("id desc") }
  scope :order_by_oldest, -> { order("id asc") }

  def voted_by?(user)
    votes.exists?(user: user)
  end
end
