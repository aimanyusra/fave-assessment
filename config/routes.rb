Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  namespace :api do
  	resources :payslip_generator do
      collection do
        post "generate"
      end
  	end
  end
end
