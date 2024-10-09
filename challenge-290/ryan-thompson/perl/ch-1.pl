#!/usr/bin/env perl
#
# 2024 Ryan Thompson <rjt@cpan.org>

use 5.036;
no warnings 'uninitialized';

# Return a true value if @ints contains a number and twice that number
# Input is defined as being explicitly integers
sub double_exist(@ints) {
    my %dubl_seen; # $dubl_seen{$x} is true iff we've already seen 2*$x
    my %half_seen; # $half_seen{$x} is true iff we've already seen $x/2

    for (@ints) {
        return 1 if $dubl_seen{$_} or $half_seen{$_};
        $half_seen{2  * $_} = 1;
        $dubl_seen{$_ /  2} = 1 if $_ % 2 == 0;
    }

    return # Double not found
}

use Test2::V0;

ok  double_exist(6, 2, 3, 3);
ok !double_exist(3, 1, 4,13);
ok  double_exist(2, 1, 4, 2);
ok  double_exist(5,16, 8, 4);
ok !double_exist(0),   '0 cannot double itself';
ok  double_exist(0,0), 'A second 0 can double the first';
ok !double_exist(1);
ok !double_exist();
ok  double_exist(-5, -10);

done_testing;
