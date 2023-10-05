class Api::V1::HealthController < ApplicationController
  def status
    render json: {
      status: 'OK',
      database_connection: ActiveRecord::Base.connected?,
      last_cron_execution: 'ultima execução',
      uptime: Time.now,
      memory_usage: `ps -o rss= -p #{Process.pid}`.to_i
    }
  end
end
