use strict;
use warnings;
use Math::Prime::Util qw/factor/;

sub get_sq_free_int{
    my $limit = shift;
    my @result;

    for my $i (1..$limit) {
        my @factors = factor($i);

        my %fact_hash;
        my $is_ok = 1;

        for my $fact(@factors) {
            $fact_hash{$fact} += 1;
            if ($fact_hash{$fact}== 2) {
                $is_ok =0;
                last;
            }
        }

        push @result, $i if $is_ok;
    }
    return join ', ', @result;

}

print get_sq_free_int(500)."\n";

use Test::More;

is(get_sq_free_int(30), '1, 2, 3, 5, 6, 7, 10, 11, 13, 14, 15, 17, 19, 21, 22, 23, 26, 29, 30');
done_testing;
