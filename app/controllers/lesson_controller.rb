class LessonController < ApplicationController
#step7が呼ばれた時だけ、アクションコールバック実行
    before_action :set_message, only: :step7

    def step1
        render text: "こんにちは、#{params[:name]}さん"
    end

    def step2
        render text: params[:controller] + "#" + params[:action]
    end

    def step3
        redirect_to action: "step4" , status:301
    end

    def step4
        render text: "step4に移動したよ！"
    end

    def step5
        flash[:notice] = "step6に移動するよ"
        # flash.noticeともかける
        redirect_to action: "step6"
    end

    def step6
        render text: flash[:notice]
    end

    def step7
        render text: @message
    end

    def step8
        @price = (2000 * 1.05).floor
    end

    def step9
        @price = 100
        render "step8"
    end

    # def show
    #     render "another/show"
    # end

    def step10
        @comment = "<script>alert('危険！')</script>こんにちは。"
    end

    def step11
        @comment = "<strong>安全なHTML</strong>"
    end

    def step12
        @population = 704414
        @surface = 141.31
    end

    def step13
        @time = Time.now
    end

    def step14
        @population = 12774928490493
    end

    def step15
        @message = "ご機嫌いかが？¥nRailsがんばろー"
    end

    def step18
        @zaiko = 100
    end

    def step19
        @items = { "フライパン" => 2680,
                    "ワイングラス" => 2550,
                    "ペッパーミル" => 4515,
                    "ピーラー" => 945 }
    end

    private
    def set_message
        @message = "こんにちは"
    end
end
