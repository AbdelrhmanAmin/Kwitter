module UsersHelper
  def error_msg(user)
    out = ''
    if user.errors.any?
     out << "<div id='error_explanation'>
        <h2>
        #{pluralize(user.errors.count, "error")} prohibited this user from being saved:
        </h2>
        <ul>
          #{err_msg(user)}
        </ul>
      </div>"
    end
    out.html_safe
  end
  def err_msg(user)
      out = ''
         user.errors.full_messages.each do |message|
          out << "<li>#{message}</li>"
        end
      out.html_safe
  end
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
  def dashboard(current_user)
    out = ''
    if user_signed_in?
      out << "<div class='d-flex  align-items-center py-3 px-3'>
          #{image_tag current_user.profile_picture(current_user)}
          #{link_to current_user.username, user_path(current_user), class: 'h6 m-3 links-color'}
        </div>
        <div class='d-flex justify-content-around followers px-1'>
          <div class='d-flex flex-column align-items-center border py-2 px-4 border-dark border-left-0'>
            <span class='followers-num'> #{current_user.following.count} </span>
            <span>
              Following
            </span>
          </div>
          <div class='d-flex flex-column align-items-center border border-right-0 py-2 px-4 border-dark '>
            <span class='followers-num'> #{current_user.followers.count} </span>
            <span>
              Followers
            </span>
          </div>
        </div>"
    end
    out.html_safe
  end
  def links(current_user)
    out = ''
      if user_signed_in?
        out << "<div class='d-flex bg-select w-100 px-3 py-2 align-items-center'>
          <i class='fa fa-user text-white'></i>
          #{link_to 'Profile', user_path(current_user), class: 'text-white w-100 h6 links-color ml-3'}
        </div>
          <div class='d-flex  w-100  px-3 py-2 align-items-center'>
            <i class='fas fa-calendar-alt'></i>
              #{link_to 'Events', events_path, class: 'w-100 h6 links-color ml-3'}
          </div>"
      else
        out << "<div class='d-flex  w-100  px-3 py-2 align-items-center'>
          <i class='fas fa-calendar-alt'></i>
            #{link_to 'Events', events_path, class: 'w-100 h6 links-color ml-3'}
        </div>
        <ul class='d-flex  w-100 mx-2  py-2 align-items-start flex-column list-unstyled'>
          <li>#{link_to 'Login', login_path}</li>
          <li>#{link_to 'signup', signup_path}</li>
        </ul>"
      end
    out.html_safe
  end
  def profile(user,current_user)
    out = ''
        if user_signed_in? 
          if !current_user.following?(user) && current_user != user
            out << "
              #{form_for(current_user.active_relationships.build) do |form|
                concat form.hidden_field :followed_id, value: user.id
                concat form.submit 'Follow', class: 'btn btn-info text-white'
            end}"
          elsif current_user != user
            out << "#{form_for(current_user.active_relationships.find_by(followed_id: user.id),
                html: { method: :delete}) do |f|
                f.submit 'Unfollow', class: 'btn btn-default'
              end}"
          end
        end
    out.html_safe
  end
  def del_post(post, user, current_user)
    out = ''
    if current_user == user
      out << "#{button_to 'Delete', post_path(post), method: :delete, class: 'btn btn-outline-danger'}"
    end
    out.html_safe
  end
  def tweet(user, current_user, post)
    out = ''
    if current_user == user
      out << "<div class='bg-white p-3 m-5'>
        <h4>TWEET</h4>
        #{form_for post, html: { class: 'form-inline' } do |form| 
          concat form.text_field :content, class: 'form-control', placeholder: 'compose a tweet' 
          concat form.submit 'TWEET', class: 'btn btn-info text-white'
        end}
      </div>"
    end
    out.html_safe
  end
end
