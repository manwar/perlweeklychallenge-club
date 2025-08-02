#!/usr/bin/env perl
$/ = undef;
my $fh = undef;
my $source;
open $fh, "<", "$0";
read $fh, $source, -s $0;
close $fh;
my @tokens = split /\s+/, $source;
my $token = $tokens[int rand scalar @tokens];
print "$token\n";
