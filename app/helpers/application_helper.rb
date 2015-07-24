module ApplicationHelper
  def homepage?
    current_page?('/')
  end
end
