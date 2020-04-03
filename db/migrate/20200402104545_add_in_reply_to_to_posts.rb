class AddInReplyToToPosts < ActiveRecord::Migration[6.0]
  def change
    add_column :posts, :in_reply_to, :text
  end
end
