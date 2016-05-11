module ApplicationHelper
  # Wraps link_to in an li tag
  # and adds class="active" if linking to the current page.
  def nav_link(*args, &block)
    content_tag(:li, class: ('active' if current_page?(args[1]))) do
      link_to(*args, &block)
    end
  end
end
