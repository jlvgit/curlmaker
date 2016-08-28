Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :curls

  root "curls#home"
  get 'list'  =>   'curls#list'

end
