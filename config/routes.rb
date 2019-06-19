Rails.application.routes.draw do
  get 'image/:id' => 'images#show'
  get 'images' => 'images#index'
  post 'images/upload' => 'images#upload'
  post 'images/upload-s' => 'images#upload_s'
  delete 'image/:id' => 'images#delete'
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
