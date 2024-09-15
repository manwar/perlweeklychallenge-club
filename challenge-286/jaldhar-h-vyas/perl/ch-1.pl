#!/usr/bin/perl
use v5.38;

open my $FILE, '<', $0;
local $/ = undef;
my $program = <$FILE>;
close $FILE;
$program =~ s/^.+\n\n//msx;
my @words = split /\s+/, $program; 
say $words[int rand scalar @words];