module PathRedirectHelper
  def path_redirect(path)
    redirect to("/#{path}?type=#{params[:type]}&id=#{@obj.id}")
  end
end