class ChengeRelationshipsToRelationshipBetweenUsers < ActiveRecord::Migration[6.1]
  def change
    rename_table :relationships, :relationship_between_users
  end
end
