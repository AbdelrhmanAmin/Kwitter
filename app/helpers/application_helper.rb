module ApplicationHelper
  def img_replacer(user)
    out = ''
    out << (if user.image.attached?
              image_tag user.profile_picture(user)
            else
              image_tag('https://placekitten.com/200/139', style: 'width: 50px; height:50px')
            end
           ).to_s
    out.html_safe
  end

  def cover_replacer(user)
    out = ''
    out << (if user.image.attached?
              image_tag user.profile_picture(user)
            else
              image_tag('https://placekitten.com/850/300', style: 'width: 850px; height:250px')
            end
           ).to_s
    out.html_safe
  end

  def event_replacer(event)
    out = ''
    out << (if event.cover.attached?
              image_tag event.profile_picture(event)
            else
              image_tag('https://placekitten.com/250/300', style: 'width: 100%; height:250px;')
            end
           ).to_s
    out.html_safe
  end
end
