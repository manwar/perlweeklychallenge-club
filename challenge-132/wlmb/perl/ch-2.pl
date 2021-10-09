#!/usr/bin/env perl
# Perl weekly challenge 132
# Task 2: Hash join
#
# See https://wlmb.github.io/2021/09/28/PWC132/#task-2-hash-join
use v5.24; # To use the funny syntax ->@*
use warnings;
use YAML::XS;

my ($index_build, $index_probe)= map {shift} @ARGV; # indices for join comparison
$/=''; #slurp
my $input=Load(my $data=<>); # Parse input
my @build=$input->[0]->@*; # Array of build tuples
my @probe=$input->[1]->@*; # Array of probe tuples
my %build; # Build hash. Each entry is array of tuples.
# Build complete 'build' hash. I assume it fits in memory.
push $build{$_->[$index_build]}->@*,  $_ foreach(@build);
foreach my $tuple(@probe){ # Iterate over probe tuples
    my $key=splice @$tuple,$index_probe,1; # remove and assign key
    # Array of all matching build tuples. Empty if none
    my @matching=defined $build{$key}?$build{$key}->@*:(); # first parts of
    say join ", ", $_->@*, @$tuple foreach @matching; # Join one build one probe tuple
}
