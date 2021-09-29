class ChangeNotNull < ActiveRecord::Migration[6.1]
  def change
    change_column_null :posts, :title, false
    change_column_null :users, :name, false
    change_column_null :users, :email, false
    change_column_null :users, :password_digest, false
    change_column_null :users, :admin, false
  end
end
