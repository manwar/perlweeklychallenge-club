#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 12901.pl
#
#        USAGE: ./12901.pl TREE_FILE
#
#  DESCRIPTION: Display distances from root to specific node
#
# REQUIREMENTS: Lingua::EN::Inflexion, Perl 5.10
#         BUGS: Whitespace, slashes and backslashes must not appear in
#               the payloads
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 06/09/21
#===============================================================================

use strict;
use warnings;
use Lingua::EN::Inflexion;

my %distance;
my $len = 0;

my $filename = shift // die "Filename missing.\n";
open my $inh, '<', $filename or die "Cannot open $filename for reading: $!";
while ($_ = <$inh>) {
	my @payloads = /[^\\\/\s]+/g;
	if (scalar @payloads) {
		for my $p (@payloads) {
			die "Non-unique payload $p.\n" if exists $distance{$p};
			$distance{$p} = $len;
		}
		$len++;
	}
}
close $inh;

while () {
	print "Node? (hit RETURN to finish) ";
	chomp (my $p = <STDIN>);
	last if $p eq '';
	if (exists $distance{$p}) {
		print inflect ("$p is <#:$distance{$p}> <N:steps> from root\n");
	} else {
		print "No matching payload $p\n";
	}
}
