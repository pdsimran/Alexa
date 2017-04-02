class CreateSiteInfos < ActiveRecord::Migration[5.0]
  def change
    create_table :site_infos do |t|

    	t.string	:name, index: true
    	t.integer	:india_rank

      t.timestamps
    end
  end
end
