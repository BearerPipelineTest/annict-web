# frozen_string_literal: true

module Canary
  module Types
    module Objects
      class Mutation < Canary::Types::Objects::Base
        field :updateStatus, mutation: Canary::Mutations::UpdateStatus

        field :skipEpisode, mutation: Canary::Mutations::SkipEpisode

        field :createAnimeRecord, mutation: Canary::Mutations::CreateAnimeRecord
        field :createEpisodeRecord, mutation: Canary::Mutations::CreateEpisodeRecord
        field :bulkCreateEpisodeRecords, mutation: Canary::Mutations::BulkCreateEpisodeRecords
        field :updateAnimeRecord, mutation: Canary::Mutations::UpdateAnimeRecord
        field :updateEpisodeRecord, mutation: Canary::Mutations::UpdateEpisodeRecord
        field :deleteRecord, mutation: Canary::Mutations::DeleteRecord

        field :addReaction, mutation: Canary::Mutations::AddReaction
        field :removeReaction, mutation: Canary::Mutations::RemoveReaction

        field :checkProgram, mutation: Canary::Mutations::CheckProgram
        field :uncheckProgram, mutation: Canary::Mutations::UncheckProgram
      end
    end
  end
end
