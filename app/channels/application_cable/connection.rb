module ApplicationCable
  class Connection < ActionCable::Connection::Base
    identified_by :current_admin

    def connect
      self.current_admin = find_verified_admin
      logger.add_tags 'ActionCable', current_admin.email
    end

    protected

    def find_verified_admin # this checks whether a admin is authenticated with devise
      
      if verified_admin = Admin.find_by(id: cookies.signed['admin.id'])
        verified_admin
      else
        reject_unauthorized_connection
      end
    end
  end
end