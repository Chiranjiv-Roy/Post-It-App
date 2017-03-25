class AddYoutubeIdToPost < ActiveRecord::Migration

  def up
  	add_column :posts, :youtube_video_id, :string
  end
  
  def down
  	remove_column :posts, :youtube_video_id
  end

end
