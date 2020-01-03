#!/usr/bin/env perl
#
# ch-2.pl - Leonardo numbers
#
# Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
use Memoize; # This is a core module

# Use core Perl module "Memoize" to store results of previous calls
# Note this is the exact same code as leo_no_memo, apart from the memoize call
sub leo_memoize {
    my $n = shift;
    return 1 if $n < 2;
    1 + leo_memoize($n - 1) + leo_memoize($n - 2);
}
memoize 'leo_memoize';

# In this case doing memoization ourselves is really easy, and turns out
# to be a surprising 777% faster than Memoize, so it's my preference.
{
    my @leo = (1, 1);
    sub leo_my_memo {
        my $n = shift;
        $leo[$n] //= 1 + leo_my_memo($n - 1) + leo_my_memo($n - 2);
    }
}

# Building up the list iteratively is also a good solution
sub leo_to_n {
    my @r = (1, 1);
    push @r, $r[-1] + $r[-2] + 1 for 2..$_[0];
    @r;
}

say for leo_to_n(20);
