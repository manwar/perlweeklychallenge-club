use strict;
use warnings;
use List::Util qw/sum/;
use Math::Combinatorics;
use Math::Prime::Util qw/divisors/;

sub is_weird {
    my $what = shift;

    my @all_divisors = divisors($what);

    # remove the number itself from the list
    pop @all_divisors;

    return 0 unless sum(@all_divisors) > $what;

    for my $i ( 1 .. scalar @all_divisors ) {
        my $p = Math::Combinatorics->new( data => \@all_divisors, count => $i );
        while ( my @res = $p->next_combination ) {
            return 0 if sum(@res) == $what;
        }
    }
    return 1;
}

use Test::More;
is( is_weird(12), 0 );
is( is_weird(70), 1 );

done_testing;
