module ApplicationHelper
  def list_tags(ticket_obj)
    str = ticket_obj.tags.map { |tag| tag.name }.join(', ')
    str == "" ? 'none' : str
  end

  def show_assignee(ticket_obj)
    assignee = ticket_obj.assignee
    assignee ? assignee.username : ""
  end

  def path_to_obj(obj)
    '/' + obj.class.table_name + '/' + obj.id.to_s
  end
end

