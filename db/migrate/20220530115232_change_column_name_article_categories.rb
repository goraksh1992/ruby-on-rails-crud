class ChangeColumnNameArticleCategories < ActiveRecord::Migration[7.0]
  def change
    rename_column :article_categories, :article, :article_id
    rename_column :article_categories, :category, :category_id
    #Ex:- rename_column("admin_users", "pasword","hashed_pasword")
  end
end
