#!/usr/bin/env perl 
#===============================================================================
#
#         FILE: 13202.pl
#
#        USAGE: ./13202.pl MEMORY_LIMIT FILE1.csv FILE2.csv
#
#               MEMORY_LIMIT is in bytes. Try 1024 or 512 for the
#               provided input.
#               FILE1.csv should be the ages, FILE2.csv the names.
#
#  DESCRIPTION: Hash Join as per
#               https://en.wikipedia.org/wiki/Hash_join#Classic_hash_join
#
# REQUIREMENTS: Devel::Size, Text::CSV,
#         BUGS: Assumes input files are UTF-8 encoded.
#        NOTES: The provided sample output's order is not replicated here
#       AUTHOR: Pete Houston (pete), cpan@openstrike.co.uk
# ORGANIZATION: Openstrike
#      VERSION: 1.0
#      CREATED: 02/10/21
#===============================================================================

use strict;
use warnings;

use Devel::Size 'total_size';
use Text::CSV;

binmode STDOUT, ":encoding(utf-8)";
my $DEBUG = 1;    # Switch to 0 for quiet mode

# Store the full names
my $mem_limit = shift;
unless ($mem_limit =~ /^[0-9]+$/) {
	warn "Supplied memory limit of $mem_limit is unusable.\n" .
		"Setting to 1024 instead.\n";
	$mem_limit = 1024;
}
my $csv = Text::CSV->new ({binary => 1});
open my $nfh, "<:encoding(utf8)", $ARGV[1] or die "Cannot open $ARGV[1]: $!";
my @names;
while (my $name = $csv->getline ($nfh)) {
	push @names, $name;
}
$csv->eof;
close $nfh;

$csv = Text::CSV->new ({binary => 1});
my $out = Text::CSV->new ({binary => 1});

# Build the hash of the ages
open my $afh, "<:encoding(utf8)", $ARGV[0] or die "Cannot open $ARGV[0]: $!";
my %ages;
while (my $row = $csv->getline ($afh)) {
	push @{$ages{$row->[1]}}, $row->[0];
	if (total_size (\%ages) >= $mem_limit) {
		print "Limit hit!\n" if $DEBUG;
		dump_out (\@names, \%ages, $out);
		%ages = ();
	}
}
close $afh;

print "At end\n" if $DEBUG;
dump_out (\@names, \%ages, $out);

sub dump_out {
	my ($names, $ages, $csv) = @_;
	for my $name (@$names) {
		for my $age (@{$ages->{$name->[0]}}) {
			$csv->combine ($age, @$name);
			print $csv->string, "\n";
		}
	}
}
