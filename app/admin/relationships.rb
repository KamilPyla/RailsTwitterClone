ActiveAdmin.register Relationship do
  index do
    selectable_column
    id_column
    column :follower
    column :followed
    column :created_at
    actions
  end
  permit_params :follower_id, :followed_id

  action_item :return_to_dashboard do
    link_to 'Dashboard', admin_root_path
  end
end
