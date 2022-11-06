# The Weekly Challenge 189
# Task 2 Array Degree

use v5.30.0;
use warnings;
use List::Util qw/uniq max/;

sub arr_deg {
    my @array = $_[0]->@*;
    my %freq;
    $freq{$_}++ foreach @array;
    my @ks = grep {$freq{$_} == max values %freq} uniq @array;
    my @r_array = @array;
    for my $k (@ks) {
        my $f;
        my $acc = 0;
        my @result = ();
        for (0..$#array) {
            if ($array[$_] == $k) {
                $acc++;
                $f = $_ if !defined($f);
            }
            push @result, $array[$_] if defined($f);
            last if $acc == $freq{$k};
        }
        @r_array = @result if scalar @result < scalar @r_array;
    }
    return [@r_array];
}

use Test::More tests=>5;
use Test::Deep;
cmp_deeply(arr_deg([1,3,3,2]), [3,3]);
cmp_deeply(arr_deg([1,2,1,3]), [1,2,1]);
cmp_deeply(arr_deg([1,3,2,1,2]), [2,1,2]);
cmp_deeply(arr_deg([1,1,2,3,2]), [1,1]);
cmp_deeply(arr_deg([2,1,2,1,1]), [1,2,1,1]);
