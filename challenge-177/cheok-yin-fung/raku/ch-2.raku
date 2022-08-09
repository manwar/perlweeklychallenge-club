# The Weekly Challenge 177
# Task 2 Palindromic Prime Cyclops
# Performance: real	0m0.294s user 0m0.441s sys 0m0.032s
use v6;

sub is-prime ($num) {
    my $k = 1;
    while ($num !%% (6*$k-1) && $num !%% (6*$k+1) && (6*$k+1 <= sqrt($num))) {
        $k++;
    }
    return $num !%% (6*$k-1) && $num !%% (6*$k+1);
}

my @arr;
my $pali = 1;

while (@arr.elems < 20) {
    if (flip $pali) !%% 2 && $pali !%% 3 && $pali !~~ /0/ {
        my $num = $pali~"0"~flip $pali;
        if is-prime($num) {
            say $num;
            push @arr, $num;
        }
    }
    $pali++;
}
