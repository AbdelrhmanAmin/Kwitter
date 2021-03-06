module SessionsHelper
  def header(current_user)
    out = ''
    out << if user_signed_in?
             "<li>#{link_to current_user.fullname, user_path(current_user), class: 'header-links h5 mr-5'}</li>
      <li> #{link_to 'logout', logout_path, class: 'header-links h5 mr-5'} </li>"
           else
             "<li> #{link_to 'Login', login_path, class: 'mx-2'} </li>
      <li> #{link_to 'signup', signup_path, class: 'mx-2'} </li>"
           end
    out.html_safe
  end
end
