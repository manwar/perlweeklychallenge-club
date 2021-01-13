#!/usr/bin/env perl
use strict;
use warnings;
 
main () unless caller;

sub shortest_prefs {
	my $wordlist = shift;
	my $prefcounts = prefcounts (@$wordlist);
	return [ map { minpref ($_, $prefcounts) } @$wordlist ];
}

sub prefcounts {
	my @wordlist = @_;
	my %counts;
	for my $word (@wordlist) {
		while (length ($word)) {
			$counts{$word}++;
			$word =~ s/.$//;
		}
	}
	return \%counts;
}

sub minpref {
	my ($word, $counts) = @_;
	for my $i (1 .. length ($word)) {
		my $pref = substr $word, 0, $i;
		return $pref if $counts->{$pref} == 1;
	}
	return ''; # If non-unique
}

sub aref_from_argv {
	# Sanitise input format
	my @in = map { s/[",]//g; $_ } grep { ! /^[[\]]$/ } @ARGV;
	return \@in;
}

sub main {
	my $out = shortest_prefs (aref_from_argv ());
	print '[ ', join (', ', map { qq{"$_"} } @$out), " ]\n";
}