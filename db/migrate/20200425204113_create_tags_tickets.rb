class CreateTagsTickets < ActiveRecord::Migration[6.0]
  def change
    create_table :tags_tickets do |t|
      t.integer :ticket_id, :tag_id
      t.timestamps
    end
  end
end
