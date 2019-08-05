#!/usr/bin/env perl
use strict;
use warnings;
use List::Util qw<pairs all any>;
use FindBin;
my $path=$ARGV[0]//($FindBin::Bin."/../words_alpha.txt");
open my $sfh, "<", ($FindBin::Bin."/../states.txt");
open my $wfh, "<",$path;
my @states=map { chomp; lc;} <$sfh>;
close $sfh;
my $longest="";
foreach(<$wfh>) {
	chomp;
	next unless length($_) % 2 == 0;
	my @p=pairs split "", lc;
	$longest= $_ if (all { my $i=join "", @{$_}; any {$_ eq $i} @states } @p) && length $_ > length $longest;
};
print "$longest\n";
close $wfh;
