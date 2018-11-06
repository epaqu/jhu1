Rails.application.routes.draw do
	get "recipes/index"
	root "recipes#index" #Make the index action the default page
end