class AddScoreToSeedSite < ActiveRecord::Migration[5.0]
  def change
  	add_column	:seed_sites,	:score,	:integer
  end
end
