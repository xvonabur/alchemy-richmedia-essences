class AddBitrateToEssenceVideos < ActiveRecord::Migration
  def change
    add_column :alchemy_essence_videos, :bitrate, :integer
  end
end
