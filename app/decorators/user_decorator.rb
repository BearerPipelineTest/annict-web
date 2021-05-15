# frozen_string_literal: true

module UserDecorator
  def name_link(options = {})
    link_to(profile.name, annict_url(:profile_url, username), options)
  end

  def role_badge
    return "" unless committer?

    content_tag(:span, class: "u-badge-outline u-badge-outline-dark") do
      role_text
    end
  end

  def name_with_username
    "#{profile.name} (@#{username})"
  end

  def avatar_url(size:)
    v4_ann_image_url(profile, :image, size: size, ratio: "1:1")
  end
end
