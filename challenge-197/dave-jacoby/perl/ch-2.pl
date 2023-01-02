#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };
use Algorithm::Permute;

my @examples = ( [ 1, 5, 1, 1, 6, 4 ], [ 1, 3, 2, 2, 3, 1 ], );

for my $e (@examples) {
    my @list = $e->@*;
    my @out  = wigglesort(@list);
    my $list = join ', ', @list;
    my $out  = join ', ', @out;
    say <<"END";
    Input:  \@list = ($list)
    Output: ($out)
END
}

sub wigglesort ( @list ) {
    my $limit = -1 + scalar @list;
    my $p     = Algorithm::Permute->new( \@list );
OUTER: while ( my @arr = $p->next ) {
        for my $i ( grep { $_ % 2 == 1 } 0 .. $limit ) {
            next OUTER if $arr[$i] <= $arr[ $i - 1 ];
            next OUTER if defined $arr[ $i + 1 ] && $arr[$i] <= $arr[ $i + 1 ];
        }
        # say join ', ', @arr;
        return @arr;
    }
    return ();
}
