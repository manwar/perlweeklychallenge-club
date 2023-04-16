# The Weekly Challenge 212
# Task 2 Rearrange Groups
use v5.30.0;
use warnings;
use List::Util qw/min all/;
use List::MoreUtils qw/frequency/;
use Data::Printer;

sub rg {
    my @list = $_[0]->@*;
    my $size = $_[1];
    my @result = ();
    while (scalar @list != 0) {
        my %freq = frequency @list;
        my $m = min @list;
        return -1 if !(all {defined($freq{$m+$_}) && $freq{$m+$_} >= $freq{$m}} 1..$size-1);
        push @result, [ $m..$m+$size-1 ] for 1..$freq{$m};
        my $first_pop = $freq{$m};
        for my $k (0..$size-1) {
            $freq{$m+$k} -= $first_pop;
        }
        @list = ();
        for my $key (keys %freq) {
            push @list, $key for 1..$freq{$key};
        }
    }
    return @result;
}

my @r;
say "Example 1";
@r = rg([1,2,3,5,1,2,7,6,3], 3);
p @r;
say "Example 2";
@r = rg([1,2,3], 2);
p @r;
say "Example 3";
@r = rg([1,2,4,3,5,3], 3);
p @r;
say "Example 4";
@r = rg([1,5,2,6,4,7], 3);
p @r;
say "modified Example 4";
@r = rg([1,5,2,6,4,7], 2);
p @r;
say "Test";
@r = rg([1,2,2,3,3,4], 3);
p @r;

