#!/usr/bin/env perl
#
# ch-1.pl - Add + and - to 123456789 so it sums to 100
#
# 2020 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

# @ops can contain any Perl binary numeric operator
# Adding more ops grows search space exponentially.
#my       @ops = qw( + - * / % >> << & | );
my        @ops = qw( + - );
my @prefix_ops = qw( + - ); # Ops which are also prefix ops

sum_split(sum => 100, num => 123456789);

# Output all possible ways to insert + and - into num, such that the
# resulting expression == sum. Named arguments:
sub sum_split {
    my %o = @_;

    if (0 == length $o{num}) {
        my $sum = eval $o{exp} // return;
        say "$sum == $o{exp}" if $sum == $o{sum};
        return
    }

    # Partition $num and recurse
    for (1..length $o{num}) {
        my ($l, $r) = unpack "A$_ A*", $o{num};
        my @cur_ops = length($o{exp}) > 0 ? @ops : @prefix_ops;
        sum_split(%o, num => $r, exp => "$o{exp}$_$l") for @cur_ops;
    }
}
