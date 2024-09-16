# The Weekly Challenge 283
# Task 1 Unique Number

use v5.30;
use warnings;
use List::MoreUtils qw/singleton/;

sub un {
    my @ints = @_;
    return (singleton @ints)[0];
}

use Test::More tests=>4;
ok un(3,3,1) == 1;
ok un(3,2,4,2,4) == 3;
ok un(1) == 1;
ok un(4,3,1,1,1,4) == 3;
