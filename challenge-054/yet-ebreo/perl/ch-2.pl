#!/usr/bin/perl
use strict;
use warnings;
no warnings 'recursion';
use feature 'say';
use Benchmark;
#Collatz conjecture
#https://perlweeklychallenge.org/blog/perl-weekly-challenge-054/

my @out;
my $r;
my %mem;
my $cnt = 0;
my $ctr = 20;
sub gen_seq {
    my ($n) = @_;
    #The if statement below improved execution time from 75 secs to 10 secs
    if ($mem{$n}) {
        $cnt    += $mem{$n} =~y/ //;
        $r      .= $mem{$n};
        return
    }
    $r .= "$n ";
    return if ($n == 1);
    gen_seq( $n & 1 ? 3*$n+1 : $n/2 );
}

my $t0 = Benchmark->new;
for my $n (2..1e6) {
    $r = "";
    gen_seq($n);
    $mem{$n} = $r;
    push @{$out[$r=~y/ //]}, "$r";
}

my $t1 = Benchmark->new;
my $td = timediff($t1, $t0);


OUTER: while (@out) {
    my $arr = pop @out;
    for my $seq (@{$arr}) {
        $seq =~/^\d+ /;
        printf ("%06d: %03d\n",$&, $seq=~y/ //);
        last OUTER if !--$ctr;
    }
}

say "Total Saved Iterations: $cnt";
say "The code took:",timestr($td),"\n";

=begin
perl .\ch-2.pl
837799: 525
626331: 509
939497: 507
704623: 504
910107: 476
927003: 476
511935: 470
767903: 468
796095: 468
970599: 458
546681: 452
818943: 450
820022: 450
820023: 450
410011: 449
615017: 447
886953: 445
906175: 445
922524: 445
922525: 445
Total Saved Iterations: 127208162
The code took:11 wallclock secs (10.03 usr +  0.53 sys = 10.56 CPU)
=cut