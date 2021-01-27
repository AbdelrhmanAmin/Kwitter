module PostsHelper
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
  def who_to_follow(users, current_user)
    out = ''
    if user_signed_in? 
      users.each do |user| 
        if !current_user.following?(user) && current_user != user 
          out << "<div class='d-flex flex-column px-4 border border-right-0 border-left-0 border-top-0'>
            <div class='d-flex py-3'>
              #{image_tag user.image, style: "width: 50px; height: 50px; display:block; border-radius: 50%"}
              #{link_to user.username, user_path(user), class: "h6 m-3 links-color" }
            </div>
          </div>"
         end 
      end
    end
    out.html_safe
  end
  def dashboard_posts(current_user)
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
  def links_posts(current_user)
    out = ''
      if user_signed_in?
        out << "<div class='d-flex w-100 px-3 py-2 align-items-center'>
          <i class='fa fa-user'></i>
          #{link_to 'Profile', user_path(current_user), class: 'w-100 h6 links-color ml-3'}
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
  def tweet_posts(post)
    out = ''
    if user_signed_in?
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
  def posts(posts)
    out = ''
      if posts.length > 0
        posts.each do |post|
           out << " <div class='d-flex py-3'>
              #{image_tag post.user.image, style: "width: 50px; height: 50px; display:block;"}
              <div class='d-flex flex-column  ml-3'>
                #{link_to post.user.username, user_path(post.user), class: "h6 links-color"}
                <span class='text-secondary'>#{post.content}</span>
              </div>
            </div>"
        end
      else
        out <<"<h5 class='p-3'>Be the first one to tweet.</h5>"
      end
      out.html_safe
  end
  def events(coming_events)
    out = ''
    coming_events.each do |event|
    out << "
      <div class='d-flex py-3'>
        #{image_tag event.creator.image, style: "width: 50px; height: 50px; display:block;"}
        <div class='d-flex flex-column  ml-3'>
          #{link_to event.creator.username, user_path(event.creator), class: "h6 links-color"}
          <span class='text-secondary'>I've just hosted <strong>#{event.title}</strong> come and #{link_to 'attend !', event_path(event)}</span>
        </div>
      </div>"
    end
    out.html_safe
  end
end
