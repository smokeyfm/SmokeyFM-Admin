module Spree
    module Api
      module V1
        class PagesController < Spree::Api::BaseController
          before_action :get_page, only: [:show]
          
          def index
            @pages = Spree::Page.find_all().where('visible is TRUE').distinct
            # @pages = Spree::Page.all
  
            # expires_in 15.minutes, public: true
  
            # headers['Surrogate-Control'] = "max-age=#{15.minutes}"
            # respond_with(@pages)
            # json_response(@pages)
            # respond_with :api, :v1, @pages
            render json: @pages
          end

          def show
            # @page = Spree::Page.finder_scope.by_store(current_store).find_by!(slug: request.path)
            @page = Spree::Page.where(Spree::Page.arel_table[:slug].matches("%#{slug}%"))
  
            # expires_in 15.minutes, public: true
  
            # headers['Surrogate-Control'] = "max-age=#{15.minutes}"
            # respond_with(@page)
            # json_response(@page)
            # respond_with :api, :v1, @page
            render json: @page
          end

          private
  
          def get_page
            begin
              @page = Spree::Page.find params[:slug]
            rescue ActiveRecord::RecordNotFound
              page = Spree::Page.new
              page.errors.add(:, "Wrong ID provided")
              render_error(page, 404) and return
            end
          end
        end
      end
    end
  end