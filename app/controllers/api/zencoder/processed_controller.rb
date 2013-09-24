class Api::Zencoder::ProcessedController < ApplicationController
  skip_before_filter :verify_authenticity_token
  http_basic_authenticate_with name: ENV['NOTIFICATION_AUTH_NAME'], 
  								password: ENV['NOTIFICATION_AUTH_PASSWORD']
  def create
    job_id = params['job']['id'].to_s
    job_state = params['job']['state'].to_s
 	  job = Job.find_by_zencoder_job_id(job_id)
  	unless job.nil? || job_state != 'finished'
      job.processed!
    end
  	render :nothing => true
  end
end
