class CreateMocks < ActiveRecord::Migration[6.1]
  def change
    create_table :mocks do |t|
      t.string :name, null: false
      t.text :description
      t.integer :status, null: false
      t.string :content_type, null: false
      t.string :request_method, null: false
      t.string :route_path, null: false
      t.string :body_type
      t.text :body_content
      t.string :script_type
      t.text :script
      t.boolean :active, null: false, default: true
      t.integer :mock_order, null: false

      t.timestamps null: false
    end

    add_index :mocks, :name, unique: true
    add_index :mocks, :mock_order, unique: true
  end
end
