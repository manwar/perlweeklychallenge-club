#!/usr/bin/env perl
# Perl weekly challenge 140
# Task 1: Add Binary
#
# See https://wlmb.github.io/2021/11/23/PWC140/#task-1-add-binary
use v5.12;
use warnings;
use integer;
use List::Util qw(all max);

my $word_size=8; # finite number of bits, to allow for negative 2s-complement numbers.
say("Usage: ch-1.pl a b [wordsize], to add two binary numbers"), exit unless @ARGV>=2;
say("Only '0' and '1' allowed for binary numbers"), exit unless all {$_=~m/^[01]+$/} @ARGV[0,1];
say("Word size should be positive"), exit unless !defined $ARGV[2] || $ARGV[2]>=1;
my ($x, $y)=map {[reverse (0,split "",$_)]} @ARGV; # bit arrays, least significant first
$word_size=$ARGV[2] if $ARGV[2];
my $length=max scalar @$x, scalar @$y;
my $carry=0;
my $r;
my @result=map {($r,$carry)=full_adder($x->[$_],$y->[$_],$carry);$r} 0..$length-1;
splice @result, $word_size; # truncate to maximum number of bits
my $result=join "", reverse @result;
say sprintf "Input: \$a=%d, \$b=%d, Output: %d", @ARGV[0,1], $result;

sub full_adder{ # add two bits and a carry, produce result and carry
    my ($a, $b, $c)=@_;
    return(($a+$b+$c)%2,($a+$b+$c)/2);
}
