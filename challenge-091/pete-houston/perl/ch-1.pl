#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9101.pl
#
#        USAGE: ./9101.pl [-v] N
#
#  DESCRIPTION: Output counts of consecutive identical digits
#
#      OPTIONS: Use -v for English verbosity
# REQUIREMENTS: Lingua::EN::Inflect for -v only, Getopt::Std
#        NOTES: The verbose option is there because the digit-only
#               output is very hard to eye-parse for a long list.
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 14/12/20
#===============================================================================

use strict;
use warnings;
use Getopt::Std;

# Do we want the verbose output?
my %opts;
getopts ('v', \%opts) or die "What?\n";
if ($opts{v}) {
	eval {
		require Lingua::EN::Inflexion;
		Lingua::EN::Inflexion->import (qw/inflect wordlist/)
	}
}

my ($char, @digits) = split //, shift;
my $count = 1;
my (@verbose, $first);

# Loop over each character
while (defined $char) {
	my $next = shift @digits;
	if (defined $next && $next eq $char) {
		$count++;
		next;
	}
	# A change of character so print (and maybe store) what we have
	print $count, $char;
	push @verbose, inflect ("<#w99:$count> <N:$char>") if $opts{v};
	$first //= $count;
	# Reset
	$count = 1;
	$char  = $next;
}
print "\n";
exit unless @verbose;

print inflect("There <#d:$first> <V:is> ") .
	wordlist (@verbose, {final_sep=>""}) .
	".\n";
