-- Q1
SELECT t.retweet_count, t.text_body, tu.screen_name, tu.category, tu.sub_category
FROM tweets t
JOIN TwitterUser tu ON t.posting_user = tu.screen_name
WHERE t.year_posted = 2016
ORDER BY t.retweet_count DESC
LIMIT 10;

-- Q2
SELECT h.tag_name, 
       COUNT(DISTINCT CASE WHEN u.state <> 'na' THEN u.state END) AS num_states, 
       GROUP_CONCAT(DISTINCT CASE WHEN u.state <> 'na' THEN u.state END) AS states_list
FROM hashtags h
JOIN hashtag_used hu ON h.tag_name = hu.tag_name
JOIN tweets t ON hu.tweet_id = t.tweet_id
JOIN TwitterUser u ON t.posting_user = u.screen_name
WHERE t.year_posted = 2016
GROUP BY h.tag_name
ORDER BY num_states DESC
LIMIT 10;

-- Q3
SELECT tu.screen_name, tu.state
FROM TwitterUser tu
JOIN tweets t ON tu.screen_name = t.posting_user
JOIN hashtag_used hu ON t.tweet_id = hu.tweet_id
JOIN hashtags h ON hu.tag_name = h.tag_name
WHERE h.tag_name IN ('iowacaucus', 'iacaucus')
GROUP BY tu.screen_name, tu.state
ORDER BY tu.followers DESC;

-- Q4
-- GOP
SELECT screen_name, 'GOP' AS party, followers
FROM TwitterUser
WHERE sub_category = 'GOP'
ORDER BY followers DESC
LIMIT 5;
-- Democrat
SELECT screen_name, 'Democrat' AS party, followers
FROM TwitterUser
WHERE sub_category = 'Democrat'
ORDER BY followers DESC
LIMIT 5;

-- Q5
SELECT DISTINCT h.tag_name, COUNT(*) AS tweet_count
FROM hashtags h
JOIN hashtag_used hu ON h.tag_name = hu.tag_name
JOIN tweets t ON hu.tweet_id = t.tweet_id
JOIN TwitterUser u ON t.posting_user = u.screen_name
WHERE u.state = 'Iowa' AND t.year_posted = 2016 AND t.month_posted = 1
GROUP BY h.tag_name
ORDER BY tweet_count DESC;

-- Q6
SELECT t.text_body, h.tag_name, tu.screen_name, tu.sub_category
FROM tweets t
JOIN hashtag_used hu ON t.tweet_id = hu.tweet_id
JOIN hashtags h ON hu.tag_name = h.tag_name
JOIN TwitterUser tu ON t.posting_user = tu.screen_name
WHERE h.tag_name = 'Iowa' 
AND tu.sub_category IN ('GOP', 'Democrat') 
AND t.year_posted = 2016 
AND t.month_posted = 2;

-- Q7
SELECT tu.screen_name, COUNT(*) AS tweet_count, GROUP_CONCAT(DISTINCT uu.url) AS url_list
FROM TwitterUser tu
JOIN tweets t ON tu.screen_name = t.posting_user
JOIN url_used uu ON t.tweet_id = uu.tweet_id
JOIN urls u ON uu.url = u.url
WHERE tu.sub_category = 'GOP' AND t.year_posted = 2016 AND t.month_posted = 1
GROUP BY tu.screen_name
ORDER BY tweet_count DESC;

-- Q8
SELECT tm.screen_name AS mentionedUser,
       tu.followers AS numFollowers,
       COUNT(DISTINCT t.posting_user) AS cntPostUser
FROM tweet_mentions tm
JOIN tweets t ON tm.tweet_id = t.tweet_id
JOIN TwitterUser tu ON tm.screen_name = tu.screen_name
GROUP BY tm.screen_name, tu.followers
ORDER BY COUNT(t.posting_user) DESC
LIMIT 10;

-- Q9
SELECT uu.url, COUNT(*) AS tweet_count
FROM url_used uu
JOIN tweets t ON uu.tweet_id = t.tweet_id
JOIN TwitterUser tu ON t.posting_user = tu.screen_name
WHERE tu.sub_category = 'GOP' AND t.year_posted = 2016 AND t.month_posted IN (1, 2, 3)
GROUP BY uu.url
ORDER BY tweet_count DESC
LIMIT 10;