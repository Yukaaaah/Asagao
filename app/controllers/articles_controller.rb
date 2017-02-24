class ArticlesController < ApplicationController
    before_action :login_required, except:[:index ,:show]

    #記事一覧
    def index
        @articles = Article.open.readable_for(current_member).order(released_at: :desc)
        .paginate(page: params[:page], per_page: 5)
    end

    #記事詳細
    def show
        @article = Article.open.readable_for(current_member).find(params[:id])
    end

# new以下削除
