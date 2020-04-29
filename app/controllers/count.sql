SELECT q.count, q.tag_id, q.name 
FROM tags INNER JOIN 
  (SELECT COUNT(*) AS count, tag_id FROM tags_tickets LEFT OUTER JOIN tags ON tags.id = tags_tickets.tag_id GROUP BY tags.id) 
  q ON tags.id = q.tag_id;

SELECT q.count, tags.id, q.name FROM tags INNER JOIN (SELECT COUNT(tags_tickets.tag_id) AS count, tags.name AS name FROM tags_tickets RIGHT OUTER JOIN tags ON tags.id = tags_tickets.tag_id GROUP BY tags.name) q ON tags.name = q.name;