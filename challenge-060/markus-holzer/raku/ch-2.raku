my @L = (0, 1, 2, 5);
my $X = 2;
my $Y = 21;

.say for ( |@L xx 2 )
    .combinations( $X )
    .map( *.join.Int )
    .unique
    .grep( * < $Y )
    .grep( *.chars == $X )
    .sort
;