-- Chapter 13: Mining Text to Find Meaningful Data

--  The style guide of a publishing company you’re writing for wants you to
-- avoid commas before suffixes in names But there are several names like
-- Alvarez, Jr. and Williams, Sr. in your database Which functions can you
-- use to remove the comma? Would a regular expression function help? How
-- would you capture just the suffixes to place them into a separate column?

SELECT replace('Williams, Sr.', ', ', ' ');
SELECT regexp_replace('Williams, Sr.', ', ', ' ');
SELECT (regexp_match('Williams, Sr.', '.*, (.*)'))[1];

-- 2 Using any one of the State of the Union addresses, count the number of
-- unique words that are five characters or more (Hint: You can use regexp
-- _split_to_table() in a subquery to create a table of words to count )
-- Bonus: Remove commas and periods at the end of each word

WITH
    word_list (word)
AS
    (
        SELECT regexp_split_to_table(speech_text, '\s') AS word
        FROM president_speeches
        WHERE speech_date = '1974-01-30'
    )

SELECT lower(
               replace(replace(replace(word, ',', ''), '.', ''), ':', '')
             ) AS cleaned_word,
       count(*)
FROM word_list
WHERE length(word) >= 5
GROUP BY cleaned_word
ORDER BY count(*) DESC;

--3 Rewrite the query in Listing 13-25 using the ts_rank_cd() function instead
-- of ts_rank() According to the PostgreSQL documentation, ts_rank_cd()
-- computes cover density, which takes into account how close the lexeme
-- search terms are to each other Does using the ts_rank_cd() function
-- significantly change the results?

SELECT president,
       speech_date,
       ts_rank_cd(search_speech_text, search_query, 2) AS rank_score
FROM president_speeches,
     to_tsquery('war & security & threat & enemy') search_query
WHERE search_speech_text @@ search_query
ORDER BY rank_score DESC
LIMIT 5;
