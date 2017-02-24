class Admin::ArticlesController < Admin::Base
    before_action :login_required, except:[:index ,:show]

    #記事一覧
    def index
        @articles = Article.readable_for(current_member).order(released_at: :desc)
        .paginate(page: params[:page], per_page: 5)
    end

    #記事詳細
    def show
        @article = Article.readable_for(current_member).find(params[:id])
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def create
        @article = Article.new(article_params)
        if @article.save
            redirect_to [:admin,@article], notice: "ニュース記事を登録しました"
        else
            render "new"
        end
    end

    def update
        @article = Article.find(params[:id])
        @article.assign_attributes(article_params)
        if @article.save
            redirect_to [:admin,@article], notice: "ニュース記事を更新しました"
        else
            render "edit"
        end
    end

    private
    def article_params
        params.require(:article).permit(:title, :body, :released_at, :expired_at, :member_only)
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        redirect_to :admin_articles
    end

end
