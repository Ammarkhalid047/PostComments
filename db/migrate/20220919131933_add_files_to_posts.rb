class AddFilesToPosts < ActiveRecord::Migration[6.1]
  def change
    add_column :posts, :files, :json
  end
end
