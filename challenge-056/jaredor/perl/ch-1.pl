#!/usr/bin/env perl
use strict;
use warnings;
use Getopt::Long;
use List::Util qw(all);

# PWC 056, Task #1

Getopt::Long::Configure( 'bundling_values', 'ignorecase_always',
    'pass_through' );

my $difference;
GetOptions( 'k=i' => \$difference ) or die "Problem with GetOptions.";

# "non negative integer k"

die "The --k option must be used to set the difference." unless defined $difference;
die "The --k option must be non-negative: $difference" unless $difference >= 0;

# "array @N of positive integers (sorted)"
# The following approach does not require input array to be sorted.

my @N = @ARGV;
die "Some arguments are not positive integers."
  unless all { $_ =~ /\A [1-9] \d* \Z/xms } @N;

my %M;
push @{ $M{ $N[$_] } }, $_ for 0 .. $#N;

my ( @answer, @output );

if ($difference) {
    @answer = grep { exists $M{$_} } map { $_ - $difference } keys %M;
    for my $subtrahend (@answer) {
        my $minuend = $subtrahend + $difference;
        for my $minidx ( @{ $M{$minuend} } ) {
            for my $subidx ( @{ $M{$subtrahend} } ) {
                push @output, [ $minidx, $subidx ];
            }
        }
    }
}
else {
    @answer = grep { @{ $M{$_} } > 1 } keys %M;
    for my $dup (@answer) {
        for my $idx1 ( 0 .. ( $#{ $M{$dup} } - 1 ) ) {
            for my $idx2 ( ( $idx1 + 1 ) .. $#{ $M{$dup} } ) {
                push @output, [ $M{$dup}->[$idx1], $M{$dup}->[$idx2] ];
            }
        }
    }
}

print join( ',', @$_ ), "\n"
  for sort { $a->[0] <=> $b->[0] or $a->[1] <=> $b->[1] } @output;
