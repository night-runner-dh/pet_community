class ApplicationController < ActionController::Base
 before_action :authenticate_admin!, if: :admin_url

def admin_url
  request.fullpath.include?("/admin")
end





def after_sign_in_path_for(resource)
  case resource
   when Admin
     admin_path
   when User
     public_homes_top_path
   else
     root_path
  end
end
end
