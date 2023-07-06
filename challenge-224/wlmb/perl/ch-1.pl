#!/usr/bin/env perl
# Perl weekly challenge 224
# Task 1:  Special Notes
#
# See https://wlmb.github.io/2023/07/03/PWC224/#task-1-special-notes
use v5.36;
use List::Util qw(all);
die <<~"FIN" unless @ARGV==2;
    Usage: $0 source target
    to find out if target may be written with non-repeated characters from source.
    FIN
my ($source, $target)=@ARGV;
my %available;
$available{$_}=1 for split "", $source; # initialize available character counts
my $output=(all {$available{$_}-- > 0} split "", $target)?"True":"False";
say "source: $source, target: $target -> $output";
