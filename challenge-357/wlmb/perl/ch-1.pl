#!/usr/bin/env perl
# Perl weekly challenge 357
# Task 1:  Kaprekar Constant
#
# See https://wlmb.github.io/2026/01/19/PWC357/#task-1-kaprekar-constant
use v5.36;
use English;
use feature qw(try);
die <<~"FIN" unless @ARGV;
    Usage: $0 N0 N1...
    to find how many iterations are required to convert the
    four digit numbers Nk to Kaprekar's constant 6174.
    In each iteration the digits of the current number are
    ordered and the smallest resulting integer is subtracted
    from the largest;
    FIN
$LIST_SEPARATOR="";
for(@ARGV){
    try {
	die "Expected four-digit inputs: $_" unless /^\d{4}$/;
	my $iterations=0;
	my $next=$_;
	while(1){
	    my @digits = sort {$a<=>$b} split "", sprintf "%04d", my $current=$next;
	    $next = "".reverse(@digits)-"@digits";
	    last if $current==$next;
	    ++$iterations
	}
	say"$_ -> ", $next!=0?$iterations:-1
    }
    catch($e){warn $e;}
}
