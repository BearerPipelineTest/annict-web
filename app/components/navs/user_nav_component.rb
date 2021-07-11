# frozen_string_literal: true

module Navs
  class UserNavComponent < ApplicationV6Component
    def initialize(view_context, user:, params:, class_name: "")
      super view_context
      @user = user
      @params = params
      @class_name = class_name
    end

    def render
      build_html do |h|
        h.tag :div, class: "c-nav #{@class_name}" do
          h.tag :ul, class: "c-nav__list" do
            h.tag :li, class: "c-nav__item" do
              h.html active_link_to t("noun.profile"), view_context.profile_path(@user.username),
                class: "c-nav__link",
                class_active: "c-nav__link--active",
                active: [profiles: :show]
            end

            h.tag :li, class: "c-nav__item" do
              h.html active_link_to t("noun.records"), view_context.record_list_path(@user.username),
                class: "c-nav__link",
                class_active: "c-nav__link--active",
                active: [records: :index, "v4/records": :show]
            end

            h.tag :li, class: "c-nav__item" do
              h.html active_link_to t("noun.library"), view_context.library_path(@user.username, :watching),
                class: "c-nav__link",
                class_active: "c-nav__link--active",
                active: @params[:controller] == "libraries" && @params[:action] == "show"
            end

            h.tag :li, class: "c-nav__item" do
              h.html active_link_to t("noun.favorites"), view_context.favorite_character_list_path(@user.username),
                class: "c-nav__link",
                class_active: "c-nav__link--active",
                active: @params[:controller].in?(%w[v3/favorite_characters favorite_people favorite_organizations]) && @params[:action] == "index"
            end

            h.tag :li, class: "c-nav__item" do
              h.html active_link_to t("noun.following"), view_context.following_user_path(@user.username),
                class: "c-nav__link",
                class_active: "c-nav__link--active",
                active: @params[:controller] == "users" && @params[:action] == "following"
            end

            h.tag :li, class: "c-nav__item" do
              h.html active_link_to t("noun.followers"), view_context.followers_user_path(@user.username),
                class: "c-nav__link",
                class_active: "c-nav__link--active",
                active: @params[:controller] == "users" && @params[:action] == "followers"
            end
          end
        end
      end
    end
  end
end
