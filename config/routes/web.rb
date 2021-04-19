# frozen_string_literal: true

USERNAME_FORMAT = /[A-Za-z0-9_]+/.freeze

get "dummy_image", to: "application#dummy_image" if Rails.env.test?

devise_for :users,
  controllers: { omniauth_callbacks: :callbacks },
  skip: %i(passwords registrations sessions)

use_doorkeeper do
  controllers applications: "oauth/applications"
  skip_controllers :authorized_applications
end

resource :confirmation, only: [:show]
resource :search, only: [:show]
resource :work_display_option, only: %i(show)
resources :comments, only: %i(edit update destroy)
resources :faqs, only: %i(index)
resources :friends, only: [:index]
resources :mute_users, only: [:destroy]
resources :notifications, only: [:index]
resources :review_comments, only: %i(edit update destroy)
resources :supporters, only: %i(index)

resources :settings, only: [:index]
scope :settings do
  resource :account, only: %i(show update)
  resource :profile, only: %i(show update), as: :profile_setting
  resources :mutes, only: [:index]
  resources :options, only: [:index]
  resources :providers, only: %i(index destroy)

  patch "options", to: "options#update"
end
namespace :settings do
  resource :password, only: %i(update)

  resources :apps, only: %i(index) do
    patch :revoke
  end

  resource :email_notification, only: %i(show update) do
    get :unsubscribe, on: :collection
  end

  resources :tokens, only: %i(new create edit update destroy)
end

resources :characters, only: %i(show) do
  resources :fans, only: %i(index), controller: "character_fans"
end

resources :channels, only: [:index]

resources :checkins, only: [] do
  # 旧リダイレクト用URL
  get "redirect/:provider/:url_hash",
    on: :collection,
    as: :redirect,
    to: "episode_records#redirect",
    provider: /fb|tw/,
    url_hash: /[0-9a-zA-Z_-]{10}/
end

resources :episodes, only: [] do
  resources :records, only: [], controller: :episode_records do
    post :switch, on: :collection
  end
end

resources :organizations, only: %i(show) do
  resources :fans, only: %i(index), controller: "organization_fans"
end

resources :people, only: %i(show) do
  resources :fans, only: %i(index), controller: "person_fans"
end

resources :users, only: [] do
  collection do
    delete :destroy
  end
end

scope "@:username", username: USERNAME_FORMAT do
  get :following, to: "users#following", as: :following_user
  get :followers, to: "users#followers", as: :followers_user
  get :ics, to: "ics#show", as: :user_ics

  get ":status_kind",
    to: "libraries#show",
    as: :library,
    constraints: {
      status_kind: /wanna_watch|watching|watched|on_hold|stop_watching/
    }

  resources :favorite_characters, only: %i(index)
  resources :favorite_organizations, only: %i(index)
  resources :favorite_people, only: %i(index)
  resources :tags, only: %i(show), controller: :user_work_tags, as: :user_work_tag
  resources :reviews, only: %i(show)

  resources :records, only: %i() do
    resources :comments, only: %i(create)
  end
end

resources :works, only: %i(index) do
  resources :episodes, only: [] do
    resources :checkins, only: %i(show)
  end

  collection do
    get :newest
    get :popular
    get ":slug",
      action: :season,
      slug: /[0-9]{4}-(all|spring|summer|autumn|winter)/,
      as: :season
  end
end

get "about", to: "pages#about"
get "legal", to: "pages#legal"
get "privacy", to: "pages#privacy"
get "terms", to: "pages#terms"

# 新リダイレクト用URL
get "r/:provider/:url_hash",
  to: "episode_records#redirect",
  provider: /fb|tw/,
  url_hash: /[0-9a-zA-Z_-]{10}/

root "home#show",
  constraints: Annict::RoutingConstraints::Member.new
root "welcome#show",
  constraints: Annict::RoutingConstraints::Guest.new,
  # Set :as option to avoid two routes with the same name
  as: nil

# rubocop:disable Layout/LineLength
constraints format: "html" do
  devise_scope :user do
    match "/sign_out", via: :delete, as: :sign_out, to: "devise/sessions#destroy"
  end

  namespace :my do
    match "/anime/:anime_id/sidebar",          via: :get,  as: :anime_sidebar,               to: "anime_sidebar#show"
    match "/episodes/:episode_id/record_form", via: :get,  as: :episode_record_form,         to: "episode_record_forms#show"
    match "/episodes/:episode_id/records",     via: :get,  as: :episode_record_list,         to: "episode_records#index"
    match "/episodes/:episode_id/records",     via: :post,                                   to: "episode_records#create"
    match "/sidebar",                          via: :get,  as: :sidebar,                     to: "sidebar#show"
    match "/receive_channel_buttons",          via: :get,  as: :receive_channel_button_list, to: "receive_channel_buttons#index"
  end

  match "/track",                                via: :get, as: :track,                  to: "tracks#show"
  match "/trackable_anime/:anime_id",            via: :get, as: :trackable_anime,        to: "trackable_anime#show"
  match "/trackable_episodes",                   via: :get, as: :trackable_episode_list, to: "trackable_episodes#index"
  match "/trackable_episodes/:episode_id",       via: :get, as: :trackable_episode,      to: "trackable_episodes#show"
  match "/works/:anime_id/episodes/:episode_id", via: :get, as: :episode,                to: "episodes#show"
end

scope module: :v4 do
  constraints format: "html" do
    devise_scope :user do
      match "/registrations",         via: :post,  as: :registrations,       to: "registrations#create"
      match "/registrations/new",     via: :get,   as: :new_registration,    to: "registrations#new"
      match "/sign_in",               via: :get,   as: :new_user_session,    to: "sign_in#new" # for Devise
      match "/sign_in",               via: :get,   as: :sign_in,             to: "sign_in#new"
      match "/sign_in",               via: :post,                            to: "sign_in#create"
      match "/sign_in/callback",      via: :get,   as: :sign_in_callback,    to: "sign_in_callbacks#show"
      match "/sign_up",               via: :get,   as: :sign_up,             to: "sign_up#new"
      match "/sign_up",               via: :post,                            to: "sign_up#create"
      match "/user_email",            via: :patch, as: :user_email,          to: "user_emails#update"
      match "/user_email/callback",   via: :get,   as: :user_email_callback, to: "user_email_callbacks#show"
    end

    match "/@:username",                                   via: :get,    as: :profile,                 to: "users#show",      username: USERNAME_FORMAT
    match "/@:username/records",                           via: :get,    as: :record_list,             to: "records#index",   username: USERNAME_FORMAT
    match "/@:username/records/:record_id",                via: :delete, as: :record,                  to: "records#destroy", username: USERNAME_FORMAT
    match "/@:username/records/:record_id",                via: :get,                                  to: "records#show",    username: USERNAME_FORMAT
    match "/episode_records",                              via: :patch,  as: :episode_record_mutation, to: "episode_records#update"
    match "/timeline_mode",                                via: :patch,  as: :timeline_mode,           to: "timeline_mode#update"
    match "/works/:anime_id",                              via: :get,    as: :anime,                   to: "works#show"
    match "/works/:anime_id/episodes",                     via: :get,    as: :episode_list,            to: "episodes#index"
    match "/works/:anime_id/records",                      via: :get,    as: :anime_record_list,       to: "anime_records#index"
    match "/works/:anime_id/records",                      via: :post,                                 to: "anime_records#create"
  end
end

scope module: :legacy do
  constraints format: "html" do
    devise_scope :user do
      match "/legacy/sign_in", via: :get,  as: :legacy_sign_in,   to: "sessions#new"
      match "/legacy/sign_in", via: :post, as: :user_session,     to: "sessions#create"
    end
  end
end
# rubocop:enable Layout/LineLength
