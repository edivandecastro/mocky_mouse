Rails.application.routes.draw do

  devise_for :users
# You can have the root of your site routed with "root"
  root to: 'mocky_mouse/home#index'

  namespace 'mocky_mouse' do
    resources :mocks, except: [:show] do
      member do
        put :activate
        put :deactivate
      end

      collection do
        put :update_order
      end
    end
  end

  get "pages/login"
  get "pages/register"

  MockyMouse::Router.load_mock_routes!
end
