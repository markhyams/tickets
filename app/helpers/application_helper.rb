module ApplicationHelper
  def list_tags(ticket_obj)
    str = ticket_obj.tags.map { |tag| tag.name }.join(', ')
    str == "" ? 'none' : str
  end

  def path_to_obj(obj)
    '/' + obj.class.table_name + '/' + obj.id.to_s
  end
end

