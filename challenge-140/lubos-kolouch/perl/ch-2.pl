use strict;
use warnings;

sub get_k_element {
    my %what = @_;

    my @result;
    for my $i ( 1 .. $what{'i'} ) {
        for my $j ( 1 .. $what{'j'} ) {
            push @result, $i * $j;
        }
    }

    @result = sort { $a cmp $b } @result;
    return $result[ $what{'k'} - 1 ];

}

use Test::More;

is( get_k_element( ( "i" => 2, "j" => 3, "k" => 4 ) ), 3 );
is( get_k_element( ( "i" => 3, "j" => 3, "k" => 6 ) ), 4 );

done_testing;
