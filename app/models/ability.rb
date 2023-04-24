# frozen_string_literal: true

class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    can :update, Review, user_id: user.id # allow a user to edit his own reviews
    can :destroy, Review, user_id: user.id
  end
end
