# frozen_string_literal: true

class Result < Dry::Struct
  schema schema.strict

  module Types
    include Dry.Types(default: :strict)
  end

  class Error < Dry::Struct
    attribute :message, Types::String
  end

  attribute :errors, Types::Array.of(Error)
end
