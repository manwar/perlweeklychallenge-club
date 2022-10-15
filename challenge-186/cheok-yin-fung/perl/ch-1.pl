# The Weekly Challenge 186
# Task 1 Zip List
use v5.30.0;
use warnings;

sub zip {
    my @all = @_;
    my $size = scalar @all / 2;
    my @a = @_[0..$size-1];
    my @b = @_[$size.. $#all];
    # say @a; say @b;
    my @ans;
    ($ans[2*$_],$ans[2*$_+1]) = ($a[$_],$b[$_]) for 0..$size-1;
    return @ans;
}

use Test::More tests=>2;
use Test::Deep;
my @a = qw/1 2 3/;
my @b = qw/a b c/;
cmp_deeply( [zip(@a, @b)], [qw/1 a 2 b 3 c/]);
cmp_deeply( [zip(@b, @a)], [qw/a 1 b 2 c 3/]);
