Rails.application.routes.draw do
  constraints(BlogConstraint.new) do
    root 'high_voltage/pages#show', id: 'blog_root'
  end

  get 'login', to: 'sessions#new'
  match 'auth/:provider/callback', to: 'sessions#create', via: [:get, :post]
  match 'logout', to: 'sessions#destroy', via: [:post, :delete]
  root 'high_voltage/pages#show', id: 'root'
end
