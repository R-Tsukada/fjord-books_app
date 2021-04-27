# frozen_string_literal: true

class AddUserRefToReports < ActiveRecord::Migration[6.1]
  def change
    add_reference :reports, :user, null: false, default: 0, index: false, foreign_key: true
  end
end
