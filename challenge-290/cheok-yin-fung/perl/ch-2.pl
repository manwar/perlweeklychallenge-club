# The Weekly Challenge 290
# Task 2 Luhn's Algorithm

use v5.30;
use warnings;
use List::Util qw/sum/;

sub digitsum {
    my $num = $_[0];
    return sum(split "", $num);
}

sub la {
    my $str = $_[0];
    my $s = scalar reverse $str;
    my @arr = grep {/[0-9]/} split "", $s;
    my $payload = shift @arr;
    my $even = sum map {$arr[$_]} grep {$_ % 2} 0..$#arr;
    my $odd = sum map {digitsum(2*$arr[$_])} grep {!($_ % 2)} 0..$#arr;
    my $ans = ($payload+$even+$odd) % 10 == 0;
}

use Test::More tests=>3;
ok la("17893729974");
ok la("4137 8947 1175 5904");
ok !la("4137 8974 1175 5904");


