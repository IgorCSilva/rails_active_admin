ActiveAdmin.register Post do

  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  permit_params :title, :content
  #
  # or
  #
  # permit_params do
  #   permitted = [:title, :content]
  #   permitted << :other if params[:action] == 'create' && current_user.admin?
  #   permitted
  # end

  # menu false
  menu label: "My Posts"
  # menu label: proc{ I18n.t "mypost" }
  # menu if: proc{ true }
  menu priority: 1
  menu parent: "Blog"
  # menu parent: ["Blog", "Personal"]

  actions :index, :show, :edit

  filter :title
  filter :content

  index do
    selectable_column
    id_column
    column :title
    column :content
    column :created_at
    column :updated_at
    actions
  end

end
