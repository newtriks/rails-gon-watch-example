class CreateJobs < ActiveRecord::Migration
  def change
    create_table :jobs do |t|
      t.string :zencoder_job_id
      t.boolean :processed

      t.timestamps
    end
  end
end
