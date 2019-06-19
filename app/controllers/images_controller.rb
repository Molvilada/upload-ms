require "base64"
class ImagesController < ApplicationController  
  skip_before_action :verify_authenticity_token

  def index
    @images = Image.paginate(page: params[:page], per_page: 10) 
      render json: @images
  end

 def upload
    @image = Image.create(image: params[:image])
    @image.save
    if @image.image.url.nil?
      render json: {error: 'Empty image request'}, status: :bad_request
    else
      @image.image_base64 = Base64.encode64(open('public'+@image.image.url).read)
      @image.iduser = params[:id_user]
      #@image.id_user = username(accessToken: params[:accessToken])
      @image.privacy = params[:privacy]
      if @image.save
        render json: {id: @image.id, image_base64: @image.image_base64.gsub("\n","")}, status: :created
      else
        render json: {error: 'Something was wrong'}, status: :bad_request
      end
    end
  end 

  def upload_s
    @image = Image.new(image: params[:image], image_base64: params[:image_base64], iduser: params[:id_user], privacy: params[:privacy])
    @image.save
    if @image.save
      render json: {id: @image.id, image_base64: @image.image_base64.gsub("\n","")}, status: :created
    else
      render json: {error: 'Something was wrong'}, status: :bad_request
    end
  
  end
  
  def create
    @image = Image.new(image_params)
    if @image.save
      render json: @image
    else
      render json: @image.errors, status: :unprocessable_entity
    end
  end

  def username
    if params[:accessToken].nil?
      render json: {error: 'AccesToken empty'}, status: :no_content
    else
      @API_URL = 'https://graph.facebook.com/me?access_token='+params[:accessToken]
      response = HTTParty.get(@API_URL)
      if response["id_user"].nil? 
        render json: {error: "Authentication error"}, status: :bad_request
      else
        return @id_user = response["id_user"]
      end  
    end
  end  

  def delete
    @image = Image.find(params[:id])
    if @image.nil?
      render json: {error: "Image id doesn't exist"}, status: :bad_request
    else
      render json: {image_id: @image.id}, status: :ok 
      @image.destroy
    end  
  end

  private

    def image_params
      params.fetch(:image, {})
    end
end
