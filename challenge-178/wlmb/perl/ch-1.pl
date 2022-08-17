#!/usr/bin/env perl
# Perl weekly challenge 178
# Task 1: Quater imaginary base
#
# See https://wlmb.github.io/2022/08/15/PWC178/#task-1-quater-imaginary-base
use v5.36;
use experimental qw(try);
use List::Util qw(pairmap);
sub st_to_reim($string){ # Parse string as X+Yi (with small variations)
    my $orig=$string;
    my $re= $string=~s/^(\s*([+-]?\d+))\s*(?!(\d|i))//?$2:0;
    my $im= $string=~s/^(\s*([+-]?\d+)\s*i\s*)$//?$2:0;
    die("$orig has the wrong format\n") unless $string=~/^$/;
    die("$orig is too big\n") unless abs($re)<= 1e5 and abs($im) <= 1e5; # to be safe
    return ($re, $im);
}
sub re_to_qi($X){ # convert a real integer number to base 2i
    state $S=0xCCCCCCCC; # Schroeppel number, enough for upto 32 bits.
    my @bits=split "", sprintf "%b", ($S+$X)^$S;
    unshift @bits,0 if @bits%2; # make length even
    join "0", pairmap {2*$a+$b} (@bits);
}
sub cmplx_to_qi($X, $Y){    # convert a complex integer number X+Yi to base 2i
    my $re=re_to_qi($X);    # convert real part
    my $im=re_to_qi(-2*$Y); # convert 2i*Yi=-2Y, with Y imaginary part
    substr $im,-2,1,'';	    # delete last digit
    $re+$im;		    # mix both parts together
}

die "Usage: $0 Z1 [Z2...]\nto convert the complex integers Zn=Xn+Yni (no space) to base 2i\n"
    unless @ARGV;
foreach (@ARGV){
    say "$_(base ten)= ",
        cmplx_to_qi(do{try {st_to_reim($_);} catch($m){say $m; next;}}),
        "(base 2i)";
}
