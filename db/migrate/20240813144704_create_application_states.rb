class CreateApplicationStates < ActiveRecord::Migration[6.1]
  def change
    create_table :application_states do |t|
      t.integer :singleton_guard, default: 0
      t.string  :mock_synchronization_token

      t.timestamps
    end

    add_index :application_states, :singleton_guard, unique: true
  end
end
