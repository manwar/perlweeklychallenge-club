use strict;
use warnings;
use 5.024;
use experimental qw<signatures>;

sub bball_ways ( $S ) {
    use constant SHOT_VALUES => [ 1, 2, 3 ];
    return [] if $S == 0;
    return    if $S <  0;

    my @ret;

    for my $n ( SHOT_VALUES->@* ) {
        push @ret, map [ $n, @{$_} ], bball_ways($S - $n);
    }

    return @ret;
}

say join(' ', @{$_}) for bball_ways( $ARGV[0] );
