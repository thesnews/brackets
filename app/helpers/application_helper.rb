module ApplicationHelper
  def full_title(title)
    base = "The Chronicle"
    if title.empty?
      base
    else
      "#{title} | #{base}"
    end
  end
end
