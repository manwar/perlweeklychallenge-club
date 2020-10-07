#!/usr/bin/env perl

use strict;
use warnings;
use 5.010;

if ($#ARGV != 1) {
   say <<USAGE;
      
        Returns the comon base strigs
        Base strings are those that can generte the original by repetition 

	ch-1.pl "aaaa" "aaaaaaaaaaaa" 
	
	returns ("a","aa","aa") the commom bases for the two strings
USAGE
   exit;
} 
my ($A,$B) = @ARGV;

say format_list( common_base($A,$B) );

sub base { 
    # bassed on Abigail's prime number regex	
    # get all base strings of $_[0] 
    # a base string is one that concateneted 0 or more times can generate 
    # the original string 
    my $orig = shift;
    my @bases;
    my $length = 1;
    while (1) {
        last unless $orig =~ /^(.{$length,}?)\1+$/;
	push @bases,$1;
	$length = 1+length($1); 
    }
    return (@bases,$orig)
}

sub format_list {
	my $out = "("; 
	while (my $val = shift) {
	    $out .= '"'.$val.'"';
	    $out .= ',' if defined $_[0];
        }
	return "$out)";
}

sub common_base {
    my @A = base(shift);
    my @B = base(shift);
    my @result;
    my $AIndex = 0;
    my $BIndex = 0;
    #Both arrays are ordered by the length of its strings
    while ($AIndex  <= $#A and $BIndex <= $#B) {
	   if ($A[$AIndex] eq $B[$BIndex]) {
		   push @result,$A[$AIndex];
		   $AIndex += 1;
		   $BIndex += 1;
		   next;
	   }
           last if length($A[$AIndex]) == length($B[$BIndex]);	   
           if (length($A[$AIndex]) > length($B[$BIndex])) {
	           $BIndex  += 1;
           } else {
		   $AIndex  += 1;
	   }	   
    }
   return @result;
}
