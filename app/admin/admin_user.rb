ActiveAdmin.register AdminUser, :as => "ADMIN" do

permit_params :email, :password, :password_confirmation, :full_name, :username, :mobile
actions :all, :except => :destroy
config.filters = false
  index do
    selectable_column
    column :full_name
    column :username
    column :email
    column :mobile
    actions
  end


  form do |f|
    f.inputs "Admin Details" do
      f.input :full_name
      f.input :username
      f.input :email
      f.input :password
      f.input :password_confirmation
      f.input :mobile
    end
    f.actions
  end

  show do
    attributes_table do
      row :full_name
      row :username
      row :email
      row :mobile
    end
  end
end

