WITH RECURSIVE
triplets AS
(
        SELECT a::numeric, b::numeric, c::numeric
        FROM generate_series( 1, 30 ) a
             , generate_series( 1, 30 ) b
             , generate_series( 1, 30 ) c
        ORDER BY a, b, c
)
, cardano_sum AS
(
        SELECT a, b, c,
               ( a + b * sqrt( c ) )   AS l
               ,( a - b * sqrt( c ) )  AS r
               FROM triplets
)
, cardano AS
(
        SELECT a, b, c, l, r
               , CASE WHEN l < 0 THEN -1 ELSE 1 END * pow( abs( l )::numeric, 1/3::numeric )
               + CASE WHEN r < 0 THEN -1 ELSE 1 END * pow( abs( r )::numeric, 1/3::numeric )
               AS triplet_sum
               FROM cardano_sum
)

SELECT *
FROM cardano
WHERE
abs( 1 - triplet_sum::numeric ) <= 0.0000000001
LIMIT 5
;
