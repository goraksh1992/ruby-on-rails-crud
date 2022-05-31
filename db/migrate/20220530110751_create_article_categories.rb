class CreateArticleCategories < ActiveRecord::Migration[7.0]
  def change
    create_table :article_categories do |t|
      t.integer :article
      t.integer :category
      t.timestamps
    end
  end
end
