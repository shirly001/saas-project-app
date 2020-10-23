Rails.application.routes.draw do

  #no need, milia will write its own version
  #root 'home#index'

  resources :user_projects
  resources :artifacts

  #resources within tenants
  #/tenants/tenant_id/projects/project_id
  resources :tenants do
    resources :projects do
      get 'users', on: :member 
      put 'add_user', on: :member 
    end
  end
  resources :members
  get 'home/index'

   root :to => "home#index"

    
  # *MUST* come *BEFORE* devise's definitions (below)
  as :user do   
    #match '/user/confirmation' => 'milia/confirmation#update', :via => :put, :as => :update_user_confirmation
    #as => :update_user_confirmation  --- url name
    match '/user/confirmation' => 'confirmations#update', :via => :put, :as => :update_user_confirmation
  end

  devise_for :users, :controllers => {
    #:registrations => "milia/registrations",
    :registrations => "registrations",
    #:confirmations => "milia/confirmations",
    :confirmations => "confirmations",
    :sessions => "milia/sessions", 
    :passwords => "milia/passwords", 
  }
  
  #as => :edit_plan --- url name
  match '/plan/edit' => 'tenants#edit', via: :get, as: :edit_plan
  match '/plan/update' => 'tenants#update', via: [:put, :patch], as: :update_plan


end
