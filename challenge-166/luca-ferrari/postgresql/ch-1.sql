-- Perl Weekly Challenge 166
-- Task 1

CREATE SCHEMA IF NOT EXISTS pwc166;

create table if not exists pwc166.dictionary( word text );
truncate pwc166.dictionary;
copy pwc166.dictionary from '/tmp/dictionary.txt';

SELECT word,
        regexp_replace(
          regexp_replace(
             regexp_replace(
                regexp_replace( lower( word ), 'o', '0', 'g' ),
                'l|i', '1', 'g' ),
                  's', '5', 'g' ),
                  't', '7', 'g' )
FROM pwc166.dictionary
WHERE
length( word ) >= 2
AND length( word ) <= 8
AND word ~* '^[a-folist]+$'
;
