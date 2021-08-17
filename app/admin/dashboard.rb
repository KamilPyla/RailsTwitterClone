ActiveAdmin.register_page "Dashboard" do
  # This file needs to be refactor!
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do

    # section "Reported Posts" do
    #   table_for Micropost.reported do |post|
    #     post.column('Post id') { |p| p.id }
    #     post.column('Author') do |p|
    #       author = User.find_by(id: p.user_id) 
    #       link_to author.name, admin_user_path(author)
    #     end
    #   end
    # end

    panel 'Show all reported posts' do
      link_to('Show all', admin_microposts_path(q: { reported_eq: true }))
    end
    panel 'Reported Posts' do
      columns do
        column { b 'Post id' }
        column { b 'Author' }
        column { b 'Content' }
        column { b 'Action' }
        column { b 'Number of reports' }
        column { b 'Comments' }
      end
      Micropost.reported.each do |post|
        author = User.find_by(id: post.user_id)
        columns do
          column do 
            'Micropost id ' + post.id.to_s
          end
          column do
            link_to author.name, admin_user_path(author)
          end
          column do
            i post.content
          end
          column do
            link_to('Show post', admin_micropost_path(post)) + ' | ' + \
            link_to('Show comments', admin_reported_comments_path(q: { micropost_id_eq: post.id }))
          end
          column do
            span post.reported_comments.size.to_s
          end
          column do
            post.reported_comments.each do |comment|
              ul link_to comment.content, admin_reported_comment_path(comment)
            end
          end
        end

      end
    end

  end # content
end
