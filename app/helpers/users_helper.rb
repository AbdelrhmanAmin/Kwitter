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
end
