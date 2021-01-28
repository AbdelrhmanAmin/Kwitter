module EventsHelper
  def editing_events(event, user)
    link_to 'Edit', edit_event_path(event) if user_signed_in? && event.creator.id == user.id
  end

  def deleting_events(event, user)
    if user_signed_in? && event.creator.id == user.id
      button_to 'Destroy', event_path(event), method: :delete, data: { confirm: 'Are you sure?' },
                                              class: 'btn btn-sm btn-outline-danger'
    end
  end

  def old_warning
    return "THIS IS AN OLD EVENT! YOU CAN'T ATTEND IT ANYMORE" if @event.date < Date.today
  end

  def attendance_checker(user)
    if user_signed_in? && @event.created_by?(user) && !@event.included?(user) && @event.date >= Date.today
      render 'attend'
    end
  end

  def attendance_date
    if @event.date < Date.today
      'This Event was attended by:'
    else
      'Attendees'
    end
  end
  def error_msg(event)
    out = ''
    if event.errors.any?
     out << "<div id='error_explanation'>
        <h2>
        #{pluralize(event.errors.count, "error")} prohibited this event from being saved:
        </h2>
        <ul>
          #{err_msg(event)}
        </ul>
      </div>"
    end
    out.html_safe
  end
  def err_msg(event)
    out = ''
       event.errors.full_messages.each do |message|
        out << "<li>#{message}</li>"
      end
    out.html_safe
  end
  def header_events
    out = ''
    if user_signed_in?
      out << "
      <li>#{link_to 'Create Event', new_event_path, class: 'header-links  text-white h5 mr-5'}</li>
      <li>#{link_to current_user.fullname, user_path(current_user), class: 'header-links h5 mr-5'}</li>
      <li>#{link_to 'logout', logout_path, class: 'header-links h5 mr-5'}</li>"
    else
      out << "<li>#{link_to 'Login', login_path, class: 'mx-2'}</li>
      <li>#{link_to 'signup', signup_path, class: 'mx-2'}</li>"
    end
    out.html_safe
  end
  def links_events(current_user)
    out = ''
      if user_signed_in?
        out << "<div class='d-flex w-100 px-3 py-2 align-items-center'>
          👤
          #{link_to 'Profile', user_path(current_user), class: 'w-100 h6 links-color ml-3'}
        </div>
          <div class='d-flex bg-select w-100  px-3 py-2 align-items-center'>
            📅
              #{link_to 'Events', events_path, class: 'w-100 h6 text-white links-color ml-3'}
          </div>"
      else
        out << "<div class='d-flex bg-select w-100  px-3 py-2 align-items-center'>
          📅
            #{link_to 'Events', events_path, class: 'w-100 h6 text-white links-color ml-3'}
        </div>
        <ul class='d-flex  w-100 mx-2  py-2 align-items-start flex-column list-unstyled'>
          <li>#{link_to 'Login', login_path}</li>
          <li>#{link_to 'signup', signup_path}</li>
        </ul>"
      end
    out.html_safe
  end
  def upcoming_events(coming_events)
    out = ''
      coming_events.each do |event|
      out << "<tr>
          <td>#{event.title}</td>
          <td>#{event.creator.fullname}</td>
          <td>#{event.date}</td>
          <td>#{link_to 'Show', event, class: 'text-success'}</td>
      </tr>"
    end
    out.html_safe
  end
  def middle_up_coming_events(coming_events)
    out = ''
    if coming_events.length > 0
     out << "<h2>Upcoming Events</h2>
      <table class='table table-bordered'>
        <thead>
          <tr>
            <th>Title</th>
            <th>Creator</th>
            <th>date</th>
          </tr>
        </thead>
        <tbody>
          #{upcoming_events(coming_events)}
        </tbody>
      </table>"
     else
      out << "<h3 class='text-center p-3'>Host an event! 🐱</h3>"
    end
    out.html_safe
  end
  def old_events(prev_events)
    out = ''
      prev_events.each do |event|
       out << "<tr>
          <td>#{event.title }</td>
          <td>#{event.creator.fullname }</td>
          <td>#{event.date }</td>
        </tr>"
      end
      out.html_safe
  end
  def right_old_events(prev_events)
    out = ''
    if prev_events.length > 0
    out <<  "<h2>Old Events</h2>
      <table class='table table-bordered'>
          <thead>
            <tr>
              <th>Title</th>
              <th>Creator</th>
              <th>date</th>
            </tr>
          </thead>
          <tbody>
            #{old_events(prev_events)}
          </tbody>
        </table>"
    end
    out.html_safe
  end
    def del_event(event, user, current_user)
    out = ''
    if current_user == user
      out << "#{button_to 'Delete', event_path(event.id), method: :delete, class: 'btn btn-outline-danger'}"
    end
    out.html_safe
  end
    def events(coming_events, current_user)
    out = ''
    coming_events.each do |event|
    out << "
      <div class='d-flex py-3 justify-content-between align-items-center'>
      <div class='d-flex py-3'>
        #{image_tag event.creator.image, style: "width: 50px; height: 50px; display:block;"}
        <div class='d-flex flex-column  ml-3'>
          #{link_to event.creator.fullname, user_path(event.creator), class: "h6 links-color"}
          <span class='text-secondary'>I've just hosted <strong>#{event.title}</strong> come and #{link_to 'attend !', event_path(event)}</span>
        </div>
      </div>
        #{del_event(event, event.creator, current_user)}
      </div>
      "
    end
    out.html_safe
  end
end