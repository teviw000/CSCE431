class Review < ActiveRecord::Base
    validates_presence_of :business_id, :user_email, :comment, :rating, :price, :safety, :service, :cash_only, :english, :tips, :wifi, :wheelchair
end