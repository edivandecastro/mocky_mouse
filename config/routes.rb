Rails.application.routes.draw do

  # devise_for :users

  # Ensure you have overridden routes for generated controllers in your routes.rb.
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

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
