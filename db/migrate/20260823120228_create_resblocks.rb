class CreateResblocks < ActiveRecord::Migration[8.1]
  def change
    create_table :resblocks do |t|
      t.string :name, null: false
      t.string :district, null: false
      t.string :bizcircle
      t.integer :built_year
      t.integer :reference_unit_price
      t.decimal :plot_ratio, precision: 4, scale: 2
      t.decimal :green_coverage_pct, precision: 5, scale: 2
      t.decimal :management_fee_cny, precision: 6, scale: 2
      t.string :building_type
      t.integer :total_unit_count
      t.integer :on_market_unit_count
      t.text :address
      t.string :source_resblock_id
      t.string :source_platform, null: false, default: "lianjia"
      t.string :source_url
      t.text :notes
      t.string :nearest_metro_station
      t.integer :metro_walk_distance_m

      t.timestamps
    end

    add_index :resblocks, [ :source_platform, :source_resblock_id ], unique: true, where: "source_resblock_id IS NOT NULL"
    add_index :resblocks, :district
    add_index :resblocks, :bizcircle
    add_index :resblocks, :built_year
    add_index :resblocks, :reference_unit_price
  end
end
