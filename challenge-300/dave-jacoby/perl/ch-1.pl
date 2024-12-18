#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use Algorithm::Permute;
my @examples = ( 1, 2, 4, 10 );

for my $example (@examples) {
    my $output = beautiful_arrangement($example);
    say <<"END";
    Input:  \$int = $example
    Output: $output
END
}

sub beautiful_arrangement ($int) {
    my @array = 1 .. $int;
    my $p     = Algorithm::Permute->new( \@array );
    my $c     = 0;
    my $l = 0;
OUTER: while ( my @p = $p->next() ) {
    $l++;
        unshift @p,'';
        for my $i ( 1 .. -1 + scalar @p ) {
            my $r1 = $i / $p[$i];
            my $r2 = $p[$i] / $i;
            my $i1 = int $r1;
            my $i2 = int $r2;
            next OUTER unless $r1 == $i1 || $r2 == $i2;
        }
        $c++;
    }
    return $c;
}
