ActiveAdmin.register User do
  permit_params :name, :email, :password, :password_confirmation, :gender, category_ids: []

  index do
    selectable_column
    id_column
    column :name
    column :email
    column :gender
    column :created_at
    column :microposts do |user|
      link_to 'Show user\'s posts', admin_microposts_path(q: { user_id_eq: user.id })
    end
    column 'number of comments' do |user|
      user.reported_comments.size
    end
    column :reported_comments do |user|
      link_to 'Show user\'s reported comments', admin_reported_comments_path(q: { user_id_eq: user.id })
    end
    column :actions do |user|
      link_to('Show', admin_user_path(user)) + ' | ' + \
      link_to('Edit', edit_admin_user_path(user)) + ' | ' + \
      link_to('Delete', admin_user_path(user), method: :delete)
    end
  end

  show do
    attributes_table do
      row :name
      row :email
      row :gender
      row :microposts do |user|
        link_to 'Show user\'s posts', admin_microposts_path(q: { user_id_eq: user.id })
      end
      row :reported_comments do |user|
        link_to 'Show user\'s reported comments', admin_reported_comments_path(q: { user_id_eq: user.id })
      end
      row :created_at
      row :user_avatar
    end
  end


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

  action_item :return_to_dashboard do
    link_to 'Dashboard', admin_root_path
  end

 
end
