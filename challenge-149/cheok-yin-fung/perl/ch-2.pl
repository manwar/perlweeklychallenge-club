# The Weekly Challenge 149
# Task 2 Largest Square

use v5.22.0;
use warnings;
use Math::BigInt;
use List::Util qw/uniq/;
use Test::More tests => 5;

my $_N = $ARGV[0] || 3;

find_sq($_N);

sub find_sq {

    my $N = $_[0];

    my $upper_sqrt = Math::BigInt->new($N)->bpow( int(($N+1)/2));
    my $sq = Math::BigInt->new($upper_sqrt)->bpow(2);

    my $bool = undef;

    do {
        $upper_sqrt->bdec();
        $sq->bsub($upper_sqrt)->bsub($upper_sqrt)->bdec();
        my $sq_baseN = $sq->to_base($N);
        my @arr = split "", $sq_baseN;
        my $uniq_num = uniq @arr;
        $bool = 1 if scalar @arr == $uniq_num;
    } while (!$bool);

    say "in decimal base: ", $sq;
    say "in base-N: ", $sq->to_base($N);

    return $sq;
}

ok find_sq(2) == 1, "N = 2";
ok find_sq(3) == 1, "N = 3";
ok find_sq(7) == 751689, "N = 7";
ok find_sq(8) == 10323369, "N = 8";
ok find_sq(12) == 8706730814089, "N = 12";
