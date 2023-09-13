with cte as(
SELECT 
  user_id, 
  COUNT(tweet_id) AS tweets_num 
FROM tweets 
WHERE tweet_date BETWEEN '2022-01-01' AND '2022-12-31' 
GROUP BY user_id)
select tweets_num as tweet_bucket,
count(user_id) as users_num
from cte 
group by tweets_num
