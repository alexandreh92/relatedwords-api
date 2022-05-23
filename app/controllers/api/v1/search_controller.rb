module Api
  module V1
    class SearchController < V1Controller
      def index
        related_words = SearchService.call(search_value: search_params[:value])
        render json: related_words
      end

      private

        def search_params
          params.permit(:value)
        end
    end
  end
end
