#!/usr/bin/env perl
# common divisors 
#

use strict;
use warnings;

use 5.010;

if (3 != @ARGV ) {
	say STDERR qq(you sould pass 3 strings quoted if they contain spaces : ./ch-2.pl " oc" casa "ca saoc");
	exit;
}

my ($A,$B,$C) = @ARGV;

say 0 and exit if length $C != length qq($A$B);

my %source =(A=>$A,B=>$B);



my $pos = 0;
my $bases = q{};

while ( length $bases  < length $C)  {
	my $check =  length $bases;
	for my $choice (qw(A B)) {
	    if ( length $source{$choice}) {
	     	if ( (substr $source{$choice},0,1 ) eq substr $C,length $bases ,1 )  {
		    $bases .= $choice;
		    (substr $source{$choice},0,1 ) = q{};
		    last;
		}
	    }

        }
	last if $check == length $bases

}

say  0 + (length $bases == length $C) ;  
