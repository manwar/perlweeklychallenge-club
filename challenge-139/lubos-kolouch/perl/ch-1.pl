use strict;
use warnings;
use Data::Dumper;

sub is_jort_sorted {
    my $what = shift;

    my @sorted_arr = sort @$what;

    my $str1 = join ' ', @$what;
    my $str2 = join ' ', @sorted_arr;

    return $str1 eq $str2 ? 1 : 0;

}

use Test::More;

is( is_jort_sorted( [ 1, 2, 3, 4, 5 ] ), 1 );
is( is_jort_sorted( [ 1, 3, 2, 4, 5 ] ), 0 );

done_testing;
