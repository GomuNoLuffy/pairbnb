class AddStatusToReservation < ActiveRecord::Migration[5.0]
  def change
  	add_column :reservations, :status, :integer, :null => false, :default => 0
  end
end
