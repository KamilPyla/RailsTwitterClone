ActiveAdmin.register Micropost do

  scope :all
  scope :reported
  scope :blocked

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :content, :user_id, :picture, :blocked, :reported
  #
  # or
  #
  # permit_params do
  #   permitted = [:content, :user_id, :picture]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end
  
end
