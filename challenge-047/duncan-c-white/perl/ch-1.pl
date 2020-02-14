#!/usr/bin/perl
#
# 
# Task 1: "Roman Calculator
# 
# Write a script that accepts two roman numbers and operation. It should
# then perform the operation on the give roman numbers and print the result.
# 
# For example,
# 
# perl ch-1.pl V + VI
# 
# should print
# 
# XI
# "
# 
# My notes: cute, especially given that we did Roman->Int and Int->Roman in challenge 10:-).
# So convert Roman->Int, Do Op, Int->Roman for the result.
# 

use feature 'say';
use strict;
use warnings;
use Data::Dumper;

use lib qw(.);
use Roman;

die "Usage: romancalc R1 OP R2    [R1 and R2 are Roman numerals or integers]\n".
    "or:    romancalc test\n"
	unless @ARGV==3 || (@ARGV==1 && $ARGV[0] eq "test");

if( @ARGV==1 && $ARGV[0] eq "test" )
{
	testroman();
	exit 0;
}

my( $r1, $op, $r2 ) = @ARGV;
my $origr1 = $r1;
my $origr2 = $r2;

$r1 = fromroman($r1) if $r1 =~ /^[MCDLXVI]+$/;
$r2 = fromroman($r2) if $r2 =~ /^[MCDLXVI]+$/;

die "romancalc: bad r1: $r1\n" unless $r1 > 1 && $r1 < 4000;
die "romancalc: bad r2: $r2\n" unless $r2 > 1 && $r2 < 4000;

my $n = eval "$r1 $op $r2" || die "romancalc: bad operator $op\n";
$n = int($n);

my $r = toroman($n);
say "result of $origr1 ($r1) $op $origr2 ($r2): $r ($n)";
