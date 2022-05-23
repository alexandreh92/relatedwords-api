module Api
  module V1
    class SearchController < V1Controller
      def index
        related_words = SearchService.call(search_value: value_for_search)
        render json: related_words
      end

      private

        def value_for_search
          search_params[:value]&.split&.first
        end

        def search_params
          params.permit(:value)
        end
    end
  end
end
