#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 15302.pl
#
#        USAGE: ./15302.pl N
#
#  DESCRIPTION: Is the provided number a factorion?
#
# REQUIREMENTS: Perl 5.10.0 for 'state'
#        NOTES: This could easily be written with List::Util::sum and
#               Math::Prime::Util::factorial but where's the challenge
#               in that?
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 21/02/22
#===============================================================================

use strict;
use warnings;
use feature 'state';

printf "%i\n", is_factorion ($ARGV[0]) ? 1 : 0;

# Instead of List::Util::sum
sub sum (@) {
	my $tot = shift;
	$tot += $_ for @_;
	return $tot;
}

# Instead of Math::Prime::Util::factorial
sub fac {
	state $have = { 0 => 1 };
	my $i = shift;
	return $have->{$i} if $have->{$i};
	my $fac = $i * fac ($i - 1);
	$have->{$i} = $fac;
	return $fac;
}

sub is_factorion {
	my $n = shift;
	return 0 unless defined ($n) && $n =~ /^[1-9][0-9]*$/;
	return $n == sum map { fac ($_) } split //, $n;
}
