#!/usr/bin/perl
# The Weekly Challenge 114
# Task 2 Higher Integer Set Bits
# Usage: ch-2.pl [positive integer]
# case I: bitstrings having the form 1..10..0
# case II : bitstring having the form 1..1
# case III: bitstrings ends with 1(s) and there exists 0 in the string
# case IV : bitstring ends with 0(s) and 
#                   there exists 0 besides the trailing zero(s)
use strict;
use warnings;
use experimental 'switch';

my $N = $ARGV[0] || 1048576; 

die "Please input a decimal positive integer.\n"
    unless $N =~ /^[1-9][0-9]*$/;

my $bitstr = sprintf("%0b",$N);

#print $N, "->", $bitstr, "->", hisb($bitstr), "->";
print bin2dec(hisb($bitstr)), "\n";



sub hisb {
    given ($bitstr) {
        when( /^[1]+[0]+$/ ) {
            my $copyo = $_;
            my $copyz = $_;
            $copyo =~ tr/0//d;
            $copyz =~ tr/1//d;
            my $n_o = length $copyo;
            my $n_z = length $copyz;
            return "1" . "0" x ($n_z+1) . "1" x ($n_o-1);
        }
        when( /^[1]+$/ ) {
            return "1"."0". "1" x  ((length $_) - 1);
        }
        when( /0/ && /1$/ ) {
            $bitstr =~ /([1]+)$/;
            my $n_end_o = length $1;
            return 
                 substr( $bitstr ,0, (length $bitstr) - $n_end_o - 1 )
                ."1"
                ."0"
                ."1" x ($n_end_o-1);
        }
        when( /0/ && /0$/ ) {
            $bitstr =~ /0([1]+)([0]+)$/;
            my $n_mid_o = length $1;
            my $n_end_z = length $2;
            return
                 substr( $bitstr, 0, (length $bitstr) - $n_mid_o - $n_end_z - 1)
                ."1"
                ."0" x ($n_end_z+1)
                ."1" x ($n_mid_o-1);
        }
    }
}

#copy from "Perl Cookbook", by Tom Christiansen & Nathan Torkington
sub bin2dec {      
    return unpack("N", pack("B32", substr("0" x 32 . $_[0], -32)));
}

