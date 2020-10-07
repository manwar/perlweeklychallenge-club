#!/usr/bin/env perl

use strict;
use warnings;

sub base { 
    # bassed on Abigil's prime number regex	
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
	    $out .= ',' if defined @_[0];
        }
	return "$out)";
}

sub common_base {
    my @A = base(shift);
    my @B = base(shift);
    my @result;
    my $AIndex = 0;
    my $BIndex = 0;
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
CORE::say format_list common_base 'aa'x210,'a'x105;
