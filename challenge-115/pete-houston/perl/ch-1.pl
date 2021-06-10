#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 11501.pl
#
#        USAGE: ./11501.pl [-e ENC ] STRING STRING [ STRING ... ]
#
#  DESCRIPTION: Print 1 if the given string set is circular, 0 otherwise
#
#      OPTIONS: use -e to specify an encoding other than UTF-8 for the
#               strings
# REQUIREMENTS: Encode, Getopt::Std, Perl 5.010 or newer
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 02/06/21
#===============================================================================

use strict;
use warnings;
use 5.010;
use Encode 'decode';
use Getopt::Std;

my $enc = get_enc ();
die "There must be a minimum of 2 string arguments\n" if 2 > @ARGV;

# Turn it into an AoH with str, start, end which is then
# sorted into a possible chain
my @sorted = sort {
		$a->{end} eq $b->{start} ? -1 :
		$b->{end} eq $a->{start} ?  1 :
		0
	} map { 
		$_ = decode ($enc, $_, Encode::FB_CROAK);
		{
			str   => $_,
			start => substr ($_,  0, 1),
			end   => substr ($_, -1, 1)
		}
	} @ARGV;

# Determine if the sorted set is really circular
for my $i (0 .. $#sorted) {
	unless ($sorted[$i - 1]->{end} eq $sorted[$i]->{start}) {
		print "0\n";
		exit;
	}
}
print "1\n";

sub get_enc {
	my %opts;
	getopts ('e:', \%opts);
	my $enc = $opts{e} // 'UTF-8';
	return $enc;
}
