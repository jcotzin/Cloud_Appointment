class AddRoomToAppointment < ActiveRecord::Migration[5.0]
  def change
    add_reference :appointments, :room, foreign_key: true
  end
end
