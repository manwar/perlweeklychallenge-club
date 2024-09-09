#!/usr/bin/perl
# SPDX-FileCopyrightText: Peter Pentchev <roam@ringlet.net>
# SPDX-License-Identifier: BSD-2-Clause

use v5.16;
use strict;
use warnings;

use FindBin;

use constant PROG => "$FindBin::Bin/$FindBin::RealScript";
use constant HASHBANG => '#!/usr/bin/perl';
use constant PWC_QUIET => ($ENV{PWC_QUIET} // '') eq 1;

sub diag($) {
	say STDERR $_[0] unless PWC_QUIET;
}

sub solve_self_spammer(;$) {
	my ($prog) = @_;

	$prog //= PROG;

	diag "About to examine $prog";
	my $contents = do {
		open my $src, '<', $prog or die "Could not open $prog for reading: $!\n";
		my $contents = do {
			local $/;
			<$src>
		};
		close $src or die "Could not read all of $prog: $!\n";

		# A quick sanity check
		if (substr($contents, length(HASHBANG) + 1) != HASHBANG."\n") {
			die "Unexpected first line in $prog, expected ".HASHBANG."\n";
		}

		# Seems fine
		$contents
	};
	diag "Read ".length($contents)." characters from $prog";

	my @words = split /\s+/, $contents;
	my $index = int rand @words;
	my $chosen_one = $words[$index];
	if ($chosen_one eq '') {
		use Data::Dumper;

		die "Empty word at index $index\n".Dumper($contents, \@words);
	}
	say "$words[$index]";
}

MAIN:
{
	solve_self_spammer();
}
