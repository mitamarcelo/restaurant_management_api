Rails.application.routes.draw do
  resources :restaurants do
    resources :menus
    resources :plates
  end

  devise_for :users,
             path: '',
             path_names: {
               sign_in: 'login',
               registration: 'signup'
             },
             controllers: {
               sessions: 'sessions',
               registrations: 'registrations'
             }

  delete 'logout', to: 'users#logout'
end
