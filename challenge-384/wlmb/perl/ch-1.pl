#!/usr/bin/env perl
# Perl weekly challenge 384
# Task 1:  Base N
#
# See https://wlmb.github.io/2026/07/27/PWC384/#task-1-base-n
use v5.40;
use feature qw(try);
$"="";
die <<~"FIN" unless @ARGV && @ARGV%2==0;
    Usage: $0 N0 B0 N1 B1...
    to write the number Ni in base Bn.
    FIN
my @digit=(0..9, "A".."Z", "a".."z", "+", "/");
my $maxbase=@digit;
for my($N,$B)(@ARGV){
    try{
        die "Base should an integer: $B" unless $B==floor $B;
        die "Base should be larger than 1: $B" unless $B>1;
        die "Base too large; can only handle up to $maxbase: $B"
            unless $B<=$maxbase;
        die "I only manage integer numbers: $N" unless floor $N==$N;
        my $sign=$N<0?"-":"";
        my $rest=$N<0?-$N:$N;
        my @output;
        while($rest){
            unshift(@output, $digit[$rest%$B]);
            $rest=floor $rest/$B;
        }
        my $output="@output";
        say"$N, $B -> $output"
    }
    catch($e){ warn $e; }
}
