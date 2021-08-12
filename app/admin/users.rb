ActiveAdmin.register User do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  form do |f|
    inputs "Details" do
      input :name
      input :email
      input :password
      input :password_confirmation
      input :gender, :as => :select, :collection => [[],["Male","m"],["Female","f"]]
    end
    actions
  end

  permit_params :name, :email, :password, :password_confirmation, :user_avatar, :gender
  
  action_item :show_posts, only: :show do
    link_to "Show Posts", "#"
  end

  # or
  #
  # permit_params do
  #   permitted = [:name, :email, :password_digest, :remember_digest, :admin, :user_avatar, :gender]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
