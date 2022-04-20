-- Perl Weekly Challenge 161
CREATE SCHEMA IF NOT EXISTS pwc161;



WITH words( word, size, sorted, unsorted )
AS (
       select word, length( word ),
        array( select regexp_split_to_table( word, '' ) order by 1 ) as sorted,
        regexp_split_to_array( word, '' ) as unsorted
       from pwc161.dictionary )
select word, size
from words
where sorted = unsorted
order by word, size asc;
