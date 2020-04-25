module ApplicationHelper
  def list_tags(ticket_obj)
    ticket_obj.tags.map { |tag| tag.name }.join(', ')
  end
end
