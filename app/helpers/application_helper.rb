module ApplicationHelper
  def render_flash_messages
    render 'shared/flash_messages' if flash.any?
  end
end
