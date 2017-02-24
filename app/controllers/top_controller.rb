class TopController < ApplicationController
  def index
    #   @message = "おはようございます"
        @articles = Article.open.readable_for(current_member).order(released_at: :desc).limit(5)
  end

  def about
  end

  def not_found
      raise ActionController::RoutingError
        "No route matches #{request.patch.inspect}"
  end

  def bad_request
      raise ActionController::ParameterMissing, ""
  end

  def internal_server_error
      raise Exception
  end
end
