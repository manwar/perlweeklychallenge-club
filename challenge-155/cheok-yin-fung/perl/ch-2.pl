#!/usr/bin/perl
# The Weekly Challenge 155
# Task 2 Pisano Period

use v5.22.0;
use warnings;
use List::Util qw/any sum/;

=pod
for command-line input:

# https://oeis.org/wiki/Index_to_OEIS:_Section_Rec

ch-2.pl $N 2   1 1       0 1   # Fibonacci numbers

ch-2.pl $N 2   1 1       2 1   # Lucas numbers    #OEIS:A000032

ch-2.pl $N 2   1 2       0 1   # Pell numbers     #OEIS:A000129

ch-2.pl $N 3   1 1 0  1 1 1 # Padovan numbers     #OEIS:A000931

ch-2.pl $N 3   1 1 1  0 0 1 # Tribonacci numbers  #OEIS:A000073

ch-2.pl $N 3   1 0 1  1 1 1 # Narayana's cows sequence #A000930

ch-2.pl $N 6  -1 -1 0 -1 2 1   1 2 2 4 5 9             #A001224

ch-2.pl $N 6   1 -1 -1 0 1 1   1 1 2 3 4 5             #A001399
=cut



if (check_commandline_args()) {
    my $iN = $ARGV[0];
    my $it = $ARGV[1];
    my $irec = [@ARGV[2..$it+1]];
    my $iseq = [@ARGV[$it+2..2*$it+1]];
    my $arr = pisano_period($iN, $it, $irec, $iseq);
    say "length: ", scalar @{$arr};
    say "terms: ", join ", ", @{$arr};
}



sub pisano_period {
    my ($N, $t, $rec, $seq) = @_;
    die "(Some of) Parameters are too large.\n"
        if $N**$t + $t - 1 > 8_000_000;

    @$seq = map {$_ % $N} @$seq;
    my $ori_seqstate = [@$seq];
    my $new_seqstate = [@$ori_seqstate];
    my $count = 0;
    do { 
        my $new_val = sum map {$rec->[$_]*$new_seqstate->[$_]} (0..$t-1);
        $new_val = $new_val % $N;
        push @{$seq}, $new_val;
        shift @{$new_seqstate};
        push @{$new_seqstate}, $new_val;
        $count++;
        die "Patterns not found\n" if $count > $N**$t + $t;
    } while (!cmp_num_arr($new_seqstate, $ori_seqstate));

    return [@$seq[0..$count-1]];
}



sub check_commandline_args {
    if (any {int $_ ne $_} @ARGV) {
        say "Some commandline arguments are not integers.";
        return 0;
    }
    return 0 if !defined($ARGV[0]) || $ARGV[0] < 2;
    return 0 if !defined($ARGV[1]) || $ARGV[1] < 2;
    return 0 if !defined($ARGV[2*$ARGV[1]+1]);
    warn "WARNING: Extra parameters are found.\n"
        if defined($ARGV[2*$ARGV[1]+2]);
    return 1;
}



sub cmp_num_arr {
    my $l_a = $_[0];
    my $l_b = $_[1];
    my $i = 0;
    while ($l_a->[$i] == $l_b->[$i]) {
        $i++;
        return 1 if $i == scalar @$l_a;
    }
    return 0;
}




use Test::More tests => 4;

ok cmp_num_arr( 
    pisano_period(3, 2, [1, 1], [0, 1]),
    [split "", "01120221"]
), "Required Case (Period of Fibonacci numbers mod 3)";

ok cmp_num_arr( pisano_period(2, 2, [1, 1], [0, 1]),
    [0, 1, 1]
), "Pisano period for mod 2";

ok cmp_num_arr( 
    pisano_period(3, 3, [1, 1, 0], [1, 1, 1]), 
    [split "", "1112201210010"] 
), "Pisano-like period for Padovan numbers mod 3";

ok cmp_num_arr(
    pisano_period(7, 3, [1, 1, 0], [1, 1, 1]), 
    [split "", "111223450252002022244613043400404441152601610010"] 
), "Pisano-like period for Padovan numbers mod 7";
