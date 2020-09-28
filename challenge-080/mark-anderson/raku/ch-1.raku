unit sub MAIN(*@ints where .all ~~ Int);

say $_ ?? .min.key !! 1 with (1..@ints.max+1) (-) @ints.map(+*); 
