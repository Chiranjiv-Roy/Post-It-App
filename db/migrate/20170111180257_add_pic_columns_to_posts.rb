class AddPicColumnsToPosts < ActiveRecord::Migration
  def up
    add_attachment :posts, :pic
  end

  def down
    remove_attachment :posts, :pic
  end
end
