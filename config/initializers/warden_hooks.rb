Warden::Manager.after_set_user do |admin,auth,opts|
  scope = opts[:scope]
  auth.cookies.signed["#{scope}.id"] = admin.id
  auth.cookies.signed["#{scope}.expires_at"] = 30.minutes.from_now
end