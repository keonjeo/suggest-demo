class CreatePostNotifiers < ActiveRecord::Migration[5.0]
  def change
    create_table :post_notifiers do |t|
      t.integer :post_id
      t.integer :notifier_id

      t.timestamps
    end

    add_index :post_notifiers, :post_id
    add_index :post_notifiers, :notifier_id
  end
end

