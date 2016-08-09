-- INSERT INTO friendships(created_at, updated_at, user_id, friend_id)
-- values(now(), now(), 2, 4);
-- -- 
SELECT users.first_name, users.last_name, user2.first_name as friend_first_name, user2.last_name as friend_last_name FROM users
join friendships on friendships.user_id = users.id
join users as user2 on user2.id = friendships.friend_id
ORDER BY user2.last_name DESC;
-- 
-- SELECT * FROM friendships;