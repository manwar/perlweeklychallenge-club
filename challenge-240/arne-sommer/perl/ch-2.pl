#! /usr/bin/env perl

use Perl6::Junction "all";

die "At least one value" unless @ARGV > 0;
die "Non-negative integers only" unless all(@ARGV) == qr/^\d+$/;

my @int        = @ARGV;
my $last_index = @int -1;
my @output     = map { $int[$int[$_]] } (0 .. $last_index);

print "(", join(", ", @output), ")\n";
