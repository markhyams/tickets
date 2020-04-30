
SELECT q.count, tags.id, q.name FROM tags INNER JOIN (SELECT COUNT(tags_tickets.tag_id) AS count, tags.name AS name FROM tags_tickets RIGHT OUTER JOIN tags ON tags.id = tags_tickets.tag_id GROUP BY tags.name) q ON tags.name = q.name;

SELECT COUNT(tags_tickets.tag_id) AS count, tags.name, tags.id AS id FROM tags_tickets RIGHT OUTER JOIN tags ON tags.id = tags_tickets.tag_id GROUP BY tags.name, tags.id ORDER BY tags.name;