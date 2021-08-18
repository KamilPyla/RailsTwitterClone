ActiveAdmin.register_page "Dashboard" do
  # This file needs to be refactor!
  menu priority: 1, label: proc { I18n.t("active_admin.dashboard") }

  content title: proc { I18n.t("active_admin.dashboard") } do
    columns do
      column do
        panel "Reported Posts" do 
          render 'reported_posts'
        end
      end
      column do
        panel "Filters" do
          ul b link_to 'Show all reported posts', admin_microposts_path(scope: :reported)
          ul b link_to 'Show all blocked posts', admin_microposts_path(scope: :blocked)
          
        end
      end
    end

  end # content
end
