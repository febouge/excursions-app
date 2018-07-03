module ApplicationHelper
  # Returns the full title.
  def full_title(page_title = '')
    base_title = I18n.t('apptitle')
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end

  # Confirms the user has admin privileges.
  def admin_user
    unless admin_user?
      flash[:danger] = I18n.t('errors.unprivileged_user')
      redirect_to root_url
    end
  end

  #Confirms that user is logged in
  def logged_in_user
    unless logged_in?
      flash[:danger] = I18n.t('errors.login_first')
      redirect_to login_url
    end
  end
end
