use strict;
use warnings;
use feature "say";
use constant MAX => 10000; # MAX must be an even number

my @primes = prime_list(MAX);
# say "@primes"; # 2 3 5 7 11 13 17 19 23 29 31 37 41 ...

my @padovans = (1, 1, 1);
for my $i (3..140) {
    $padovans[$i] = $padovans[$i-2] + $padovans[$i-3]
}
# say "@padovans"; # 1 1 1 2 2 3 4 5 7 9 12 16 21 28 37 ...

my $count = 0;
my $last_pad = 0;
for my $pad (@padovans) {
    next if $pad == $last_pad;
    $last_pad = $pad;
    next unless is_prime($pad);
    say $pad;
    $count++;
    last if $count > 9;
}

sub prime_list {
    my $max = shift;
    my @prime_list = (2, 3, 5);
    PRIMES: for my $c (7..$max) {
            for my $i (2..$c/2) {
                next PRIMES unless $c % $i;
            }
            push @prime_list, $c;
    }
    return @prime_list;
}
sub is_prime {
    my $num = shift;
    for my $prime (@primes) {
        return 1 if $num == $prime;
        return 0 if $prime > $num;
        return 0 unless $num % $prime;
    }
    my $test = MAX+1;
    while ($test < int(sqrt($num))) {
        return 0 unless $num % $test;
        $test += 2;
    }
    return 1;
}
