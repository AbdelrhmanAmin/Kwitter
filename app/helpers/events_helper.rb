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
end