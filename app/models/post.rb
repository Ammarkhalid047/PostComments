class Post < ApplicationRecord

    scope :get_approvals, -> {where(status:'pending')}
    scope :get_approved, -> {where(status:'approved')}


    # scope :comments_count, -> { self.comments.count }

    enum status: {pending: 0, approved: 1, rejected: 2 }

    mount_uploaders :images, ImageUploader
    mount_uploaders :files, FileUploader
    belongs_to :user
    has_many :comments, dependent: :destroy


    def comments_count
        self.comments.count
    end


end
