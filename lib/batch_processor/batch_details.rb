# frozen_string_literal: true

# The details of a batch represent the state of the work to process.
module BatchProcessor
  class BatchDetails < RedisHash::Base
    include Spicerack::HashModel

    attr_reader :batch_id

    alias_method :data, :itself

    field :started_at, :datetime
    field :enqueued_at, :datetime
    field :aborted_at, :datetime
    field :ended_at, :datetime

    field :size, :integer, default: 0
    field :enqueued_jobs_count, :integer, default: 0
    field :pending_jobs_count, :integer, default: 0
    field :running_jobs_count, :integer, default: 0
    field :successful_jobs_count, :integer, default: 0
    field :failed_jobs_count, :integer, default: 0
    field :canceled_jobs_count, :integer, default: 0
    field :retried_jobs_count, :integer, default: 0
    field :cleared_jobs_count, :integer, default: 0

    allow_keys _fields

    class << self
      def redis_key_for_batch_id(batch_id)
        "#{name}::#{batch_id}"
      end
    end

    def initialize(batch_id)
      @batch_id = batch_id
      super redis_key: self.class.redis_key_for_batch_id(batch_id)
    end
  end
end
