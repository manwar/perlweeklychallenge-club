WITH RECURSIVE
letters( l ) AS (
        SELECT *
        FROM regexp_split_to_table( 'PERL', '' )
)
, permutations AS
(
        SELECT l, l AS perm, 1 AS level
        FROM letters

        UNION ALL

        SELECT l.l, p.perm || l.l AS perm, level + 1
        FROM letters l, permutations p
        WHERE level <= 100
        AND position( l.l IN p.perm ) = 0
)

SELECT perm
FROM permutations
WHERE length( perm ) = 4
AND perm NOT IN (
'PELR',
'PREL',
'PERL',
'PRLE',
'PLER',
'PLRE',
'EPRL',
'EPLR',
'ERPL',
'ERLP',
'ELPR',
'ELRP',
'RPEL',
'RPLE',
'REPL',
'RELP',
'RLPE',
'RLEP',
'LPER',
'LPRE',
'LEPR',
'LRPE',
'LREP'
)
;
