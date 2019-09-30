class RecommendJob
  include Sidekiq::Worker
  sidekiq_options queue: 'suggest-workers'

  def perform(user_id)
    # Do something later
    puts "=========================================================\n"
    puts "recommend job for notifier_id (#{user_id}) is running ...\n"
    puts "=========================================================\n"
    RecommendService.new(user_id).run
  end
end
