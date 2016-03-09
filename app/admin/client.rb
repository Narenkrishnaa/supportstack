ActiveAdmin.register User, :as => "client" do

  permit_params :first_name, :last_name, :department_id, :role_id, :mobile_no, :email, :password, :password_confirmation, :client, attachment_attributes: [:attachment]

  scope :active_client
  scope :inactive_client

  index do
    selectable_column
    column :first_name
    column :mobile_no
    column :email
    actions
  end

filter :department

  form do |f|
    f.inputs "Client Details" do
      f.input :first_name
      f.input :last_name
      f.input :role_id, as: :hidden, value: Role.find_by(name: "client").try(:id)
      f.input :client, as: :hidden, value: true
      f.input :mobile_no
      f.input :email
      f.input :password if f.object.new_record?
      f.input :password_confirmation if f.object.new_record?
    end
    f.inputs "Attachment", for: [:attachment, (f.object.attachment.present? ? f.object.attachment : f.object.build_attachment)] do |s|
    s.input :attachment, :as => :file, :hint => s.template.image_tag(s.object.attachment), :label => "attachment"
   end
    f.actions
  end
  
  show do
    attributes_table do
      row :first_name
      row :email
      row :mobile_no
    end
  end

  controller do
    def scoped_collection                                                                                                                                                                                                                                                
      @clients=User.client
    end
  end


  controller do 
    def destroy
      @client = User.find_by(id: params[:id])
      @client.update(active: false)
      redirect_to "/admin/clients"
    end
  end
end
