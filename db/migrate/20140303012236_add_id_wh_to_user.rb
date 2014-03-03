class AddIdWhToUser < ActiveRecord::Migration
  def change
    add_column :users, :idwh, :integer
  end
end
