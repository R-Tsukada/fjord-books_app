# frozen_string_literal: true

class CreateComments < ActiveRecord::Migration[6.1]
  def change
    create_table :comments do |t|
      t.string :commentable_type
      t.string :commentable_id
      t.integer :user_id
      t.text :body

      t.timestamps
    end
  end
end
