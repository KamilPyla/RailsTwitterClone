ActiveAdmin.register Micropost do

  scope :all
  scope :reported
  scope :blocked

  permit_params :content, :user_id, :category_id, :picture, :blocked, :reported

  index do
    selectable_column
    id_column
    column :content
    column :category do |post|
      post.category.name_en if post.category
    end
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

  action_item :return_to_dashboard do
    link_to 'Dashboard', admin_root_path
  end

  member_action :block do
    resource.update(blocked: true, reported: false)
    redirect_to resource_path, notice: 'Post has been blocked.'
  end

  action_item :block, only: :show, if: proc { !resource.blocked } do
    link_to 'Block', [:block, :admin, resource]
  end

  member_action :unblock do
    resource.update(blocked: false, reported: false)
    redirect_to resource_path, notice: 'Post has been blocked.'
  end

  action_item :unblock, only: :show, if: proc { resource.blocked } do
    link_to 'Unblock', [:unblock, :admin, resource]
  end

  member_action :discard_report do
    resource.update(reported: false, blocked: false)
    redirect_to resource_path
  end

  action_item :discard_report, only: :show, if: proc { resource.reported } do
    link_to 'Discard report', [:discard_report, :admin, resource]
  end

  batch_action :block do |posts|
    batch_action_collection.find(posts).each do |post|
      post.update(blocked: true, reported: false)
    end
    redirect_to collection_path, allert: "Posts have been blocked."
  end

  batch_action :unblock do |posts|
    batch_action_collection.find(posts).each do |post|
      post.update(blocked: false, reported: false)
    end
    redirect_to collection_path, allert: "Posts have been unblocked."
  end

  batch_action :report do |posts|
    batch_action_collection.find(posts).each do |post|
      post.update(reported: true)
    end
    redirect_to collection_path, allert: "Posts have been reported."
  end
  
  batch_action :discard_report do |posts|
    batch_action_collection.find(posts).each do |post|
      post.update(reported: false)
    end
    redirect_to collection_path, allert: "Reports have beed discarted."
  end
end
