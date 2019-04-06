# frozen_string_literal: true

module Types
  module Objects
    class SeriesType < Types::Objects::Base
      implements GraphQL::Relay::Node.interface

      global_id_field :id

      field :annict_id, Integer, null: false
      field :name, String, null: false
      field :name_ro, String, null: false
      field :name_en, String, null: false

      field :works, Connections::SeriesWorkConnection, null: true, connection: true

      def works
        object.series_works
      end
    end
  end
end
