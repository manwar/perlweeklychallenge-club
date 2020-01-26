#!/usr/bin/env perl
#
# ch-2.pl - Double or +1
#
# Ryan Thompson <rjt@cpan.org>

use warnings;
use strict;
use feature qw< signatures current_sub say >;
no warnings 'experimental::signatures';

say "@{[ double_or_plus(1, 200) ]}";
say "@{[ exhaustive(1, 200, 9) ]}";

# Just work backwards
sub double_or_plus( $start, $end ) {
    my @path = $end;
    while ($end != $start) {
        $end = $end % 2 ? $end - 1 : $end / 2;
        unshift @path, $end;
    }
    @path;
}

# This is only necessary if you don't trust double_or_plus
sub exhaustive( $start, $end, $max_path ) {
    my @shortest = (0) x ($max_path + 1);

    sub ( $start, $end, @path ) {
        push @path, $start;

        return if @path > @shortest or $start >  $end;
        @shortest = @path and return if $start == $end;

        __SUB__->($start + 1, $end, @path);
        __SUB__->($start * 2, $end, @path); 
    }->($start, $end);

    @shortest;
}
