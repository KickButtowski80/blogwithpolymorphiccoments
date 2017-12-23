

Rack::Builder.new do
    #randome key https://www.jamesbadger.ca/2012/12/18/generate-new-secret-token/
  use Rack::Session::Cookie, :secret => "c751b2faa8672244bf6ff06090ee67c2d79be222187d8bf734d3d87b8be6b4edfe17058dfbde1cf9462c195dfa237003ceb8854290639a6dc4518b3736bccc3a"

  use Warden::Manager do |manager|
    manager.default_strategies :password, :basic
    manager.failure_app = BadAuthenticationEndsUpHere
     
  end
  


#   run SomeApp
end