#!/usr/bin/env perl
# Perl weekly challenge 097
# Task 1: Binary substrings
#
# See https://wlmb.github.io/2021/01/25/PWC097/#task-2-binary-substrings
use warnings;
use strict;
use v5.12;

use List::Util qw(all reduce);
use Scalar::Util qw(looks_like_number);
use Memoize; # Just for fun
# Check arguments
usage() unless @ARGV==2;
my $string = shift @ARGV;
my $length=shift @ARGV;
usage() unless looks_like_number($length) && $length>=1;

my %binary=("0"=>1,"1"=>1); # Binary characters
usage() unless all {$binary{$_}} split '', $string;

my @substrings=grep {length $_ == $length} split /(\d{$length})/, $string;

memoize('cost'); # Don't duplicate effort
my @total_costs=map {total_cost($substrings[$_], @substrings)} 0..@substrings-1;
my $best_index=reduce {$total_costs[$a]<=$total_costs[$b]?$a:$b} 0..@total_costs-1;
my $target=$substrings[$best_index];
my @costs=map {cost($target, $_)} @substrings;

say "Input:\t\"$string\"\t$length\n",
    "Output:\t$total_costs[$best_index]\n\n",
    "Binary substrings\n",
    map {"\"$substrings[$_]\": $costs[$_] flips to convert it to \"$target\"\n"}
        0..@substrings-1;

sub total_cost {
    my $first=shift;
    my $cost=0;
    $cost+=cost($first,$_) foreach @_;
    return $cost;
}
sub cost {
    my @first=split '',shift;
    my @second=split '',shift;
    my $cost=0;
    $cost += $first[$_]!=$second[$_]?1:0 foreach 0..@first-1;
    return $cost;
}

sub usage {
say <<END;
 Usage:
   ./ch-1.pl B S
   to split binary string B into substrings of size S>=1
   and then enumerate changes to make them the same
END
   exit 1;
}
