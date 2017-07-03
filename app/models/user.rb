class User < ApplicationRecord


  has_many :sent_messages, class_name: :Message, foreign_key: :sender_id
  has_many :received_messages, class_name: :Message, foreign_key: :receiver_id

  has_many :friendships
  has_many :friends, through: :friendships

  has_many :friend_requests
  has_many :initiated_friend_requests, class_name: :FriendRequests, foreign_key: :initiator_id
  has_many :accepted_friend_requests, class_name: :FriendRequests, foreign_key: :acceptor_id
end
