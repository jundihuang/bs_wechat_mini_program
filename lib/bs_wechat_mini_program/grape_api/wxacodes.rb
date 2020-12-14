# frozen_string_literal: true

class BsWechatMiniProgram::API::Wxacodes < Grape::API
  namespace :wxacodes, desc: "微信小程序授权登录" do
    desc "获取小程序分享二维码"
    params do
      requires :appid, type: String, desc: "小程序id"
      optional :page, type: String, desc: "小程序页面"
      requires :scene, type: String, desc: "小程序页面参数"
      optional :width, type: Integer, desc: "二维码宽度"
      optional :is_hyaline, type: Boolean, desc: "是否需要透明底色"
      optional :auto_color, type: Boolean, desc: "自动配置线条颜色"
    end
    get "getwxacodeunlimit" do
      error!("401 Unauthorized", 401) unless current_user
      scene = params[:scene]
      content_type "application/octet-stream;charset=ASCII-8BIT"
      env["api.format"] = :binary

      application = BsWechatMiniProgram::Application.find_by!(appid: params[:appid])
      application.client.getwxacodeunlimit(
        scene: scene,
        page: params[:page],
        width: params[:width] || 280,
        is_hyaline: params[:is_hyaline],
        auto_color: params[:auto_color]
      )
    end
  end
end
