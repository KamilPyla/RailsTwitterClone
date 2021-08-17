ActiveAdmin.register ReportedComment do
    permitted = [:content, :micropost_id, :user_id]

    index do
      selectable_column
      id_column
      column :content
      column :created_at
      column :micropost
      column 'Author', :user
      column :actions do |comment|
        link_to('Show', admin_reported_comment_path(comment)) + ' | ' + \
        link_to('Edit', edit_reported_comment_path(comment)) + ' | ' + \
        link_to('Delete', admin_reported_comment_path(comment), method: :delete)
      end
    end

    show do
      attributes_table do
        row :content
        row :created_at
        row :micropost do |comment|
          post = Micropost.find_by(id: comment.micropost_id)
          link_to 'Micropost#'+post.id.to_s, admin_micropost_path(post)
        end
        row "Author", :user do |comment|
          user = User.find_by(id: comment.user_id)
          link_to user.name, admin_user_path(user)
        end
      end
    end

  
end
