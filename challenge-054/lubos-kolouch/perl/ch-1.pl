#!/usr/bin/env perl
use strict;
use warnings;
use feature qw/say/;
use Algorithm::Permute;

sub get_nth_permutations {

    my ( $n, $k ) = @_;

    my @numbers = ( 1 .. $n );

    my $p = Algorithm::Permute->new(\@numbers, $n);

    my @all_perms;
    while (my @res = $p->next) {
        push @all_perms, join("", @res);
    }
    
    my @sorted_perms = sort @all_perms;
    return $sorted_perms[$k-1];
}

say(get_nth_permutations( 3, 4 ));

use Test::More;

is(get_nth_permutations(3, 4),'231');
done_testing();

