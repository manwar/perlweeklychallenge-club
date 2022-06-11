use strict;
use warnings;

# keep seen factorials in a cache to speed things up
my %fact_cache = (0 => 1);
my %left_fact_cache; 

sub calculate_factorial {
    my $what = shift;

    return $fact_cache{$what} if $fact_cache{$what};

    # let's utilize the fact that we are processing the numbers in sequence
    $fact_cache{$what} = $what * $fact_cache{$what-1};

    return $fact_cache{$what};
}

sub calculate_left_fact {
    my $what = shift;

    return $left_fact_cache{$what} if $left_fact_cache{$what};

    # let's utilize the fact that we are processing the numbers in sequence
    $left_fact_cache{$what} = calculate_factorial($what-1) + $left_fact_cache{$what-1};

    return $left_fact_cache{$what};
}


sub get_left_factorials {
    my $what = shift;

    my @output;

    for (1..$what) {
       push @output, calculate_left_fact($_);
    }

    return \@output;
}

use Test::More;

is_deeply(get_left_factorials(10), [1, 2, 4, 10, 34, 154, 874, 5914, 46234, 409114]);
done_testing;
