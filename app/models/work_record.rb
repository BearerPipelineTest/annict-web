# frozen_string_literal: true

# == Schema Information
#
# Table name: work_records
#
#  id         :bigint           not null, primary key
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_work_records_on_deleted_at            (deleted_at)
#  index_work_records_on_locale                (locale)
#  index_work_records_on_oauth_application_id  (oauth_application_id)
#  index_work_records_on_record_id             (record_id) UNIQUE
#  index_work_records_on_user_id               (user_id)
#  index_work_records_on_work_id               (work_id)
#
# Foreign Keys
#
#  fk_rails_...  (oauth_application_id => oauth_applications.id)
#  fk_rails_...  (record_id => records.id)
#  fk_rails_...  (user_id => users.id)
#  fk_rails_...  (work_id => works.id)
#

class WorkRecord < ApplicationRecord
  include Recordable

  self.ignored_columns = %w[
    aasm_state
    body
    deleted_at
    impressions_count
    likes_count
    locale
    modified_at
    oauth_application_id
    rating_overall_state
    rating_animation_state
    rating_music_state
    rating_story_state
    rating_character_state
    record_id
    title
    user_id
    work_id
  ]
end
