# frozen_string_literal: true

module Types
  module Objects
    class StaffType < Types::Objects::Base
      implements GraphQL::Relay::Node.interface

      global_id_field :id

      field :annict_id, Integer, null: false
      field :name, String, null: false
      field :name_en, String, null: false
      field :role_text, String, null: false
      field :role_other, String, null: false
      field :role_other_en, String, null: false
      field :sort_number, Integer, null: false
      field :work, Types::Objects::WorkType, null: false
      field :resource, Types::Unions::StaffResourceItem, null: false
    end
  end
end
