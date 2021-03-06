Rails.application.routes.draw do	
	
	post 'bank_accounts/add_operation'
	get 'bank_accounts/delete_operation'
	
	post 'bank_accounts/define_date'
	
	post 'bank_accounts/update_operation'
	
	post 'operation_classifications/edit'
	post 'operation_classifications/update'
	post 'operation_classifications/add_operation_classification'
	
	get 'operations/check'
	get 'operations/uncheck'
	
	resources 	:bank_accounts, 
				:operations, 
				:users, 
				:operation_classifications,
				:transfers
	
	get 'home/login'
	post 'home/login'
	get 'home/index'
	get 'home/logout'

	get 'users/new'
	post 'users/create'
	
	get 'stats/evolution_solde'
	post 'stats/evolution_solde_data'
	get 'stats/operation_distribution'
	post 'stats/operation_distribution_data'
	get '/stats/evolution_poste'
	post '/stats/evolution_poste_data'
	post '/stats/input_output_data'
	
	
	#get 'bank_account/index'
	#get 'bank_account/new'
	#post 'bank_account/create'
	#get 'bank_account/edit'
	#post 'bank_account/update'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#login'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
