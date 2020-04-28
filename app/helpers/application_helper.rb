module ApplicationHelper
  def show_updated_at(obj)
    return '' if obj.updated_at == obj.created_at
    
    "Updated #{time_ago_in_words(obj.updated_at)} ago."
  end

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

