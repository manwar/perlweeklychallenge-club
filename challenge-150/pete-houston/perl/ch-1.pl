#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15001.pl
#
#        USAGE: ./15001.pl A B 
#
#  DESCRIPTION: Output "Fibonacci strings" starting with A and B
#               and the 51st char of the first string to have that many
#
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 31/01/22
#===============================================================================

use strict;
use warnings;

my $offset = 51;

my @fib = @ARGV[0,1];
die "Unequal lengths.\n" unless length ($fib[0]) eq length ($fib[1]);

while ($offset > length $fib[1]) {
	push @fib, $fib[0] . $fib[1];
	shift @fib;
	print "$fib[1]\n";
}

printf "Char at position %i is %s\n",
	$offset,
	substr ($fib[1], $offset - 1, 1);
