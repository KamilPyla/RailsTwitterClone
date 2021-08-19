module MicropostsHelper

  def create_select_for_category
    Category.all.map do |cat|
      [proper_category_language(cat), cat.id.to_s]
    end.push([t('category.no_category'),nil]).reverse!
  end
end
