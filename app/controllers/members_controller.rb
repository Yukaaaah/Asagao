class MembersController < ApplicationController
    before_action :login_required

    def index
        @members = Member.order("number")
        .paginate(page: params[:page], per_page: 15)
    end

    def show
        @member = Member.find(params[:id])
        if params[:format].in?(["jpg","png","gif"])
            send_image
        else
            render "show"
        end
    end

    # new以下のアクションを削除（adminに移管）
end
