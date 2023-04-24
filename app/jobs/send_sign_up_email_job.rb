class SendSignUpEmailJob < ApplicationJob
  queue_as :default

  def perform(user)
    @user = user
    UserMailer.new_user(@user).deliver_now
  end
end
