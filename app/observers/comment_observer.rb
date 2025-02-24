class CommentObserver < ApplicationObserver
  def after_save(comment)
    return if (Rails.env.development? || Rails.env.local_production?)

    warned_user_ping(comment)
  rescue StandardError
    puts "error"
  end
end
