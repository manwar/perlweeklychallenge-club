use strict;
use warnings;
use feature 'say';
use List::Util 'all';

sub is_strobogrammatic {
    my $n = shift;
    my %strobo_pairs = ('0' => '0', '1' => '1', '6' => '9', '8' => '8', '9' => '6');
    my @str_n = split //, $n;
    return all { $strobo_pairs{$str_n[$_]} eq $str_n[-$_-1] } 0..@str_n/2;
}

sub find_strobogrammatic {
    my ($A, $B) = @_;
    return grep {is_strobogrammatic($_)} $A..$B;
}

# test cases to validate the solution

use Test::More;
is_deeply([find_strobogrammatic(50, 100)], [69, 88, 96], 'Test Case 1');
done_testing();

