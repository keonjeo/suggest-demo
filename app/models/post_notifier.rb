class PostNotifier < ApplicationRecord
  belongs_to :post

  after_commit :caculate_for_recommend, on: :create

  private
  def caculate_for_recommend
    RecommendJob.perform_async(self.notifier_id)
  end
end


