# frozen_string_literal: true

module Api
  module V1
    class SearchController < V1Controller
      def index
        related_words = SearchService.call(search_value: search_params[:value])
                                     .paginate(page: search_params[:page], per_page: search_params[:per_page])
        render json: {
          collection: related_words,
          page: related_words.current_page,
          per_page: related_words.per_page,
          total_entries: related_words.total_entries,
          total_pages: related_words.total_pages
        }
      end

      private

        def search_params
          params.permit(:value, :page, :per_page)
        end
    end
  end
end
