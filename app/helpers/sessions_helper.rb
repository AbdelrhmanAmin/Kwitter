module SessionsHelper
  def header(current_user)
    out = ''
    if user_signed_in?
      out << "<li>#{link_to current_user.username, user_path(current_user), class: 'header-links h5 mr-5'}</li>
      <li> #{link_to 'logout', logout_path, class: 'header-links h5 mr-5'} </li>"
    else
      out << "<li> #{link_to 'Login', login_path, class: 'mx-2'} </li>
      <li> #{link_to 'signup', signup_path, class: 'mx-2'} </li>"
    end
    out.html_safe
  end
end
