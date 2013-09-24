class JobsController < ApplicationController
  respond_to :html
  before_filter :find_job, :only => [:show, :destroy]
  def index
    @jobs = Job.all
    exposeUnProcessedJobsToJavascript()
    if !params[:_method].present?
      respond_to do |format|
        format.html
      end
    end
  end

  def show
    respond_to do |format|
      format.html
    end
  end

  def new
    @job = Job.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @job = Job.new(params[:job])

    response = new_zencoder_job()

    unless response.body['id'].nil?
      @job.zencoder_job_id = response.body['id']
      @job.processed = false;
    end

    respond_to do |format|
      if @job.save
        format.html { redirect_to @job, notice: 'Job was successfully created.' }
      else
        format.html { render action: "new" }
      end
    end
  end

  def destroy
    @job.destroy

    respond_to do |format|
      format.html { redirect_to jobs_url }
    end
  end

  private
    def new_zencoder_job
      return Zencoder::Job.create({
        :input => 's3://zencodertesting/test.mov', 
        :notifications => [:url => ENV['PROCESSED_WEBHOOK']],
        :test => true})
    end

    def find_job
       @job = Job.find(params[:id])
       exposeUnProcessedJobToJavascript()
    end

    def exposeUnProcessedJobToJavascript
      if(!@job.processed)
        gon.watch.job = @job.zencoder_job_id
      end
    end

    def exposeUnProcessedJobsToJavascript
      gon.watch.jobs = Job.unprocessed.pluck(:zencoder_job_id)
    end
end
