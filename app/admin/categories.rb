ActiveAdmin.register Category do
  permit_params :name_en, :name_pl, :name_it, :name_cn
  
  controller do
    def destroy
      category = Category.find(params[:id])
      category.microposts.each { |mpost| mpost.update(category_id: nil) }
      category.destroy
      flash[:success] = 'Category has been deleted.'
      redirect_to admin_categories_path
    end
  end

end
