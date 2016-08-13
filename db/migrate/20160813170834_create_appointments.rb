class CreateAppointments < ActiveRecord::Migration[5.0]
  def change
    create_table :appointments do |t|
      t.datetime :start_time
      t.datetime :end_time
      t.date :start_date
      t.date :end_date

      t.timestamps
    end
  end
end
