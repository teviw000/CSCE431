class CreateReviews < ActiveRecord::Migration[6.0]
  def change
    create_table :reviews do |t|
      t.string :name
      t.string :city
      t.string :country
      t.integer :review
      t.integer :cost
      t.float :latitude
      t.float :longitude
      t.text :description
      t.text :tags
      t.string :phone

      t.timestamps
    end
  end
end
