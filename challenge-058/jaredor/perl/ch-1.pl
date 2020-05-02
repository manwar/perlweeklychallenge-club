#!/usr/bin/env perl

use v5.012;    # Using keys on arrays
use warnings;
use List::Util qw(max min uniq);

# PWC 058, Task #1 : Compare Version

sub vercmp {

    die "Exactly two arguments are required." unless @_ == 2;

    for my $vstr (@_) {
        die "Disallowed character, $1, in version string: $vstr"
          if $vstr =~ /([^0-9._])/xms;
        die "Missing version in version string: $vstr"
          if $vstr =~ /\A [._] /xms;
        die "Missing subversion in version string: $vstr"
          if $vstr =~ / [._](?:[._]|\Z) /xms;
    }

    my $v1 = $_[0];
    $v1 =~ s/\./.1./g;
    $v1 =~ s/_/.0./g;
    my @v1 = split( /\./, $v1 );

    my $v2 = $_[1];
    $v2 =~ s/\./.1./g;
    $v2 =~ s/_/.0./g;
    my @v2 = split( /\./, $v2 );

    for my $i ( 0 .. max( $#v1, $#v2 ) ) {
        my $lendiff = length( $v2[$i] ||= 0 ) - length( $v1[$i] ||= 0 );
	my $zeros = '0' x abs $lendiff;
        if    ( $lendiff > 0 ) { $v1[$i] = $zeros . $v1[$i]; }
        elsif ( $lendiff < 0 ) { $v2[$i] = $zeros . $v2[$i]; }
    }

    return join( '', @v1 ) cmp join( '', @v2 );
}

# Input arguments will be, pairwise, the version numbers to compare.

my @v1v2 = @ARGV;

# If no input arguments, use problem statement example.

@v1v2 = qw( 0.1    1.1
  2.0    1.2
  1.2    1.2_5
  1.2.1  1.2_1
  1.2.1  1.2.1 ) unless @v1v2;

die "There needs to be an even number of version numbers." if @v1v2 % 2;

my $v1len = max( 6, map { length $v1v2[$_] } grep { not $_ % 2 } keys @v1v2 );
my $v2len = max( 6, map { length $v1v2[$_] } grep { $_ % 2 } keys @v1v2 );

my $fmt = "%${v1len}s %1s %-${v2len}s %4s\n";

print "\n";
printf $fmt, 'v1', ' ', 'v2', 'Result';
print '-' x ( $v1len + 1 ), ' ', '-' x ( $v2len + 1 ), ' ', '------', "\n";
while (@v1v2) {
    my $v1         = shift @v1v2;
    my $v2         = shift @v1v2;
    my $cmp        = vercmp $v1, $v2;
    my $cmp_symbol = $cmp == 1 ? '>' : $cmp == -1 ? '<' : '=';
    printf $fmt, $v1, $cmp_symbol, $v2, $cmp;
}
print "\n";
