module ApplicationHelper

  def fix_url str
    str.starts_with?("http://") ? str : "http://#{str}"
  end

  def format_timestamp str
    str.strftime('%a, %d %b %Y %r %Z')
    #Thu, 21 Dec 2000 16:01:07
  end
end
