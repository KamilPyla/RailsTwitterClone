module CategoriesHelper
  
  def proper_category_language(category)
    case locale
      when :en
        category.name_en
      when :pl
        category.name_pl
      when :it
        category.name_it
      when :cn
        category.name_cn
      else
        category.name_en
    end
  end
end
