#!/usr/bin/perl
use strict;
use warnings;

my %data;
my @files;

map { push @files, $_ if -e $_; }@ARGV;

foreach ( @files ) {
	open my $fh, "<", $_ or die $!;

	while ( <$fh> ) {
		chomp($_);
		s/[\W\d]//g;
		map{ $data{$_}++ } split //, lc( $_ );
	}
	
	close $fh;
}

map{ printf "%s: %s\n", $_, $data{$_}; }sort { $a cmp $b } keys %data;
