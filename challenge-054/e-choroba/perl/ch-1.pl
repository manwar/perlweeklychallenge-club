#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };

use List::Util qw{ product };

sub perm_recurse {
    my ($k, @n) = @_;
    return "" unless @n;

    my $factorial = product(1 .. @n);
    my $step = $factorial / @n;

    my $select = int($k / $step);
    --$select unless $k % $step;

    return $n[$select]
        . perm_recurse(($k % $step) || $step,
                       @n[ grep $_ != $select, 0 .. $#n ])
}

sub kth_perm { perm_recurse($_[1], 1 .. $_[0]) }


my ($n, $k) = @ARGV;
say kth_perm($n, $k);

__END__

use Test::More;

is kth_perm(3, 1), '123';
is kth_perm(3, 2), '132';
is kth_perm(3, 3), '213';
is kth_perm(3, 4), '231';
is kth_perm(3, 5), '312';
is kth_perm(3, 6), '321';

is kth_perm(4, 8), '2143';
is kth_perm(9, 362879), '987654312';

is perm_recurse(10, 'a' .. 'z'), 'abcdefghijklmnopqrstuvxyzw';

done_testing();
