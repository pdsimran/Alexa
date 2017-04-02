class AddIndexToSeedSite < ActiveRecord::Migration[5.0]
  def change
  	add_index		:seed_sites,	:name
  end
end
