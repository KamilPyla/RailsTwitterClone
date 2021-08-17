ActiveAdmin.register Micropost do

  scope :all
  scope :reported
  scope :blocked

  permit_params :content, :user_id, :picture, :blocked, :reported

  index do
    id_column
    column :content
    column :created_at
    column 'Author', :user
    column :reported_comments do |post|
      link_to 'Reported comments', admin_reported_comments_path(q: {micropost_id_eq: post.id })
    end
    column :reported
    column :blocked
    column :actions do |post|
      link_to('Show', admin_micropost_path(post)) + ' | ' + \
      link_to('Edit', edit_admin_micropost_path(post)) + ' | ' + \
      link_to('Delete', admin_micropost_path(post), method: :delete)
    end
  end

  show do
    attributes_table do  
      row :content
      row :created_at
      row 'Author' do |post|
        user = User.find_by(id: post.user_id)
        link_to user.name, admin_user_path(user)
      end
      row :reported_comments do |post|
        link_to 'Reported comments', admin_reported_comments_path(q: {micropost_id_eq: post.id })
      end
      row :reported
      row :blocked
    end
  end

end
