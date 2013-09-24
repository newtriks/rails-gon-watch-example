class Job < ActiveRecord::Base
  attr_accessible :processed, :zencoder_job_id
  validates_presence_of :zencoder_job_id
  scope :unprocessed, where(:processed => false)

  def processed!
    update_attribute(:processed, true)
  end

  def processed_label
  	if processed 
  		return 'Finished'
  	else 
  		return  'Processing'
  	end
  end
end
