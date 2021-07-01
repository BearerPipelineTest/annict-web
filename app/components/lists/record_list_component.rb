# frozen_string_literal: true

module Lists
  class RecordListComponent < ApplicationV6Component
    def initialize(view_context, records:, show_box: true)
      super view_context
      @records = records
      @show_box = show_box
      @pagenation = @records.respond_to?(:first_page?)
    end

    def render
      build_html do |h|
        h.tag :div, class: "c-record-list" do
          if @records.present?
            @records.each do |record|
              h.tag :div, class: "mt-3" do
                h.tag :turbo_frame, id: dom_id(record) do
                  h.html Contents::RecordContentComponent.new(view_context, record: record, show_box: @show_box).render
                end
              end
            end

            if @pagenation
              h.tag :div, class: "mt-3 text-center" do
                h.html ButtonGroups::PaginationButtonGroupComponent.new(view_context, collection: @records).render
              end
            end
          else
            h.html EmptyV6Component.new(view_context, text: t("messages._empty.no_records")).render
          end
        end
      end
    end
  end
end
