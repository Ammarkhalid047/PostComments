ActiveAdmin.register Post do
  
  config.action_items.delete_if do |item|
     item.name == :new && item.display_on?(:index)
  end
  
  index do |post|
    selectable_column
    id_column
    column :title
    column :description do |post|
      raw(post.description)
    end
    column :created_at
    column :comments_count
    actions defaults: true do |post|
       link_to "Change Status", admin_posts_change_status_path(post),method: 'post', class: "member_link"
    end
  end

  form do |f|
    f.semantic_errors # shows errors on :base
    inputs 'Details' do
      input :user
      input :title
      input :description , :as => :ckeditor, :class => 'ckeditor' 
      input :images, as: :file , input_html: { multiple: true }
    end
    f.actions         # adds the 'Submit' and 'Cancel' buttons
  end

  
  show do
    h3 post.title
    div do
      attributes_table do 
        row :title
        row :description do |post| 
          raw(post.description) 
        end
        row :created_at 
        row :status
      end
      attributes_table_for post.comments do
        row :rating
        row :description 
      end 
      
    end
    
  end

  controller do
    def show
      @post = Post.find(params[:id])
      @comments = @post.comments
    end

    def change_status
      @post = Post.find(params[:id])
      if @post.status == 'pending'
         @post.update(status:'approved')
          PostMailer.post_approved(@post).deliver_now
         redirect_to admin_posts_path
         flash.alert = "Post Approved."
      elsif @post.status == 'approved'
         @post.update(status: 'pending')
         redirect_to admin_posts_path
         flash.alert = "Changed Post Status to pending."
      end
    end
    
  end
  
  # See permitted parameters documentation:
  # https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
  #
  # Uncomment all parameters which should be permitted for assignment
  #
  # permit_params :title, :user_id, :description, :images, :status, :files
  #
  # or
  #
  permit_params do
    permitted = [:title, :user_id, :description, :images, :status, :files]
    permitted << :other if params[:action] == 'create' && current_user.admin?
    permitted
  end
  
end
