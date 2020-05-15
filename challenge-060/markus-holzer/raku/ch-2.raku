my @L = (0, 1, 2, 5);
my $X = 2;
my $Y = 21;

.say for ( |@L xx $X )
    .combinations( $X )
    .map( *.join.Int )
    .grep( * < $Y )
    .grep( *.chars == $X )
    .unique
    .sort
;