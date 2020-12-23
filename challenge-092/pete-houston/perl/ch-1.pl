#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 9201.pl
#
#        USAGE: ./9201.pl  
#
#  DESCRIPTION: ./9201.pl "STRING" "STRING"
#
#      OPTIONS: Output 1 if the 2 strings are isomorphic, zero otherwise
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 22/12/20
#===============================================================================

use strict;
use warnings;

print isomorphic(@ARGV[0,1]) . "\n";

sub isomorphic {
	my @str = @_;
	return 0 unless length $str[0] == length $str[1];

	my %seen;
	for my $i (0 .. length ($str[0]) - 1) {
		my $x = substr ($str[0], $i, 1);
		my $y = substr ($str[1], $i, 1);
		return 0 if exists $seen{$x} && $seen{$x} ne $y;
		next if exists $seen{$x};
		$seen{$x} = $y;
	}
	%seen = map { $seen{$_} => $_ } keys %seen;
	$str[1] =~ s/(.)/$seen{$1}/sg;
	return $str[0] eq $str[1] ? 1 : 0;
}

__END__

use Test::More tests => 5;

is isomorphic ('abc', 'xyz'), 1;
is isomorphic ('abb', 'xyy'), 1;
is isomorphic ('add', 'sum'), 0;
is isomorphic ('sum', 'add'), 0;
is isomorphic ('sum', 'no'), 0;
