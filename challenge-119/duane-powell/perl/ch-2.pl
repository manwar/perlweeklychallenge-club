#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';

# Problem: https://perlweeklychallenge.org/blog/perl-weekly-challenge-119/ TASK #2

my $N = shift || 1;
$N = seq_without_1_on_1($N);
say $N;
exit;

sub seq_without_1_on_1 {
    my $N = shift;

    # init counter i, Nth in sequence n, and base4 number t
    my ($i, $n, $t) = (1, 0, 1);
    # loop until we reach the Nth number in the sequence
    while ($n < $N) {
        # base4 number can only be composed of the digits 0-3
        $t = base4($i++); 

        # discard this number if it matches '0' or '11'
        next if ($t =~ m/0|11/); 

        $n++;
    }
    return $t
}

sub base4 {
    my $n = shift;

    return $n if ($n == 0 || $n == 1 || $n == 2 || $n == 3);
    my $k = int($n/4);
    my $b = $n % 4;
    my $E = base4($k);
    return $E . $b;
}

__END__

./ch-2.pl 5
13
./ch-2.pl 10
32
./ch-2.pl 60
2223
./ch-2.pl 1223
2222222
./ch-2.pl 1929 
3333333
./ch-2.pl 10000
231233321

