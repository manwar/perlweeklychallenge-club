unit sub MAIN( *@A );

my &neg = *.grep: * < 0;

say + neg                       # find and count all negative numbers of
  ( [X] map { +$_, -$_ }, @A )  # all possible candidates
  .classify( *.sum )            # grouped by sum
  .grep( *.key > -1 )           # filtered where sum is positive
  .sort( *.key )                # sorted by sum
  .head.value                   # closest to zero
  .min( &neg )                  # the one with the least flips   

