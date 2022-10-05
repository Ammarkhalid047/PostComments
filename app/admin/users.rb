ActiveAdmin.register User do
  index do
    selectable_column
    id_column
    column :email
    column :name
    column :age
    column :role
    column :status
    column :created_at
    column :total_posts
    actions defaults: true do |user|
      link_to "Change Status", admin_users_change_user_path(user),method: 'post', class: "member_link"
    end
  end

  show do
      h3 user.name
      div do
        attributes_table :email, :name, :age, :role, :status, :created_at, :total_posts
        attributes_table_for user.post do
          row :title
          row :description
        end 
      end
  end
      
  form do |f|
    f.semantic_errors # shows errors on :base
    f.inputs 'Details' do 
      f.input :name
      f.input :email
      f.input :age
      f.input :image
      f.inputs "Address" do
        f.semantic_fields_for :address_attributes, user.address do |j|
        j.inputs do
          j.input :country, :as => "string" 
          j.input :city
          j.input :street
        end
        end
      end
      input :password
      input :password_confirmation
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end
  
  
    controller do

      def permitted_params
        params.permit!
      end

      def change_user
        @user = User.find(params[:id])
        if @user.status == 'inactive'
          @user.update(status:'active')
       elsif @user.status == 'active'
          @user.update(status: 'inactive')
       end
       UserMailer.user_status(@user).deliver_now
       redirect_to admin_users_path
       flash.alert = "User Status Has changed!"
      end
      
    
  end
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :email, :encrypted_password, :reset_password_token, :reset_password_sent_at, :remember_created_at, :name, :image, :age, :role, :status, :confirmation_token, :confirmed_at, :confirmation_sent_at, :unconfirmed_email
  #
  # or
  #
  permit_params do
    permitted = [:email, :password, :remember_created_at, :name, :image, :age, :role, :status, address_attributes: [:country, :city, :street]]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
