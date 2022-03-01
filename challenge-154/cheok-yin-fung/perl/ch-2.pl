#!/usr/bin/perl


# Todo: quit $NAX_NUM_OF_SEARCHES


use v5.22.0;
use warnings;
use Math::BigInt;

use Math::Prime::Util ':all';
prime_precalc(10_000_000);



my $NUM_OF_TERMS = $ARGV[0] || 10;
my $MAX_NUM_OF_SEARCHES = $ARGV[1] || $NUM_OF_TERMS*10;

die "The search parameter is too small.\n"
    if $MAX_NUM_OF_SEARCHES < $NUM_OF_TERMS;


my @ans = ();
my $pdvstate = [];

core();


sub pdv_iter {
    $pdvstate = [Math::BigInt->new(1), Math::BigInt->new(1), Math::BigInt->new(1), Math::BigInt->new(2)]
      unless defined $pdvstate->[0];
    my ($a, $b, $c, $d) = @{$pdvstate};
    ($a, $b, $c, $d) = ($b, $c, $d, $b+$c);
    @$pdvstate = ($a, $b, $c, $d);
    return $c;
}



sub core {
    my $ind = 3;
    while (1) {
        if (!$pdvstate) {
            pdv_n();
            next;
        }
        my $Pk = pdv_iter();
        if (is_prob_prime($Pk)) {
            update_ans($Pk);
        }
        $ind++;
    }
}



sub update_ans {
    my $candidate = $_[0];
    push @ans, $candidate if   defined($ans[-1]) 
                            && $candidate != $ans[-1];
    push @ans, $candidate if !defined($ans[-1]);
    if (scalar @ans >= $NUM_OF_TERMS) {
        say join "\n", @ans;
        exit;
    }
}
