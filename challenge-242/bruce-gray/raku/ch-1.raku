sub task1 ( @ns1, @ns2 ) {
    return (@ns1, @ns2).permutations.map:
        *.reduce( &[(-)] ).keys.sort.List;
}



my @tests =
    { in => ( (1, 2, 3)    , (2, 4, 6)    ), expected => ( (1, 3) , (4, 6) ) },
    { in => ( (1, 2, 3, 3) , (1, 1, 2, 2) ), expected => ( (3,  ) , (    ) ) },
;
use Test; plan +@tests;
for @tests {
    is-deeply task1(|.<in>), .<expected>;
}
