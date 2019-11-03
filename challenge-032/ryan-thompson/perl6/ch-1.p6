#!/usr/bin/env perl6

# Instance Count
#
# Same basic algorithm as the p5 version, just a little more Raku-ish.
# We read a line at a time so we don't have to store all lines in RAM.
#
# Ryan Thompson <rjt@cpan.org>

# Bit of a hack. Normal preference would be MAIN(Bool :$csv) or Getopt::Long
my $csv = (@*ARGS[0] and @*ARGS[0] eq '-csv') ?? @*ARGS.shift !! False;

my %count;
%count{ $*ARGFILES.get }++ while ! $*ARGFILES.eof;

my $key_width = %count.  keys.race.map({.chars}).max;
my $int_width = %count.values.race.map({.chars}).max;
my $fmt = $csv ?? "%s,%s\n" !! "%-{$key_width}s %{$int_width}d\n";

$fmt.printf(.key, .value) for %count.sort: { .value, .key };
