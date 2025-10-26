class ApplicationController < ActionController::Base
  include Authentication
  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern
  # ATTENTION Active Storage setup
  # 1. BEFORE : install Active Storage tables
  #      bin/rails active_storage:install + db:migrate
  # 2. connect Active Storage to views
  include ActiveStorage::SetCurrent
end
