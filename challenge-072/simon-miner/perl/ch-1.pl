use strict;
use warnings;

my $n = shift @ARGV;
die "Please specify a number between 1 and 10.\n" unless $n =~ m/^\d+$/ && $n <= 10;

my $fact = 1;
$fact *= $_ for ( 1 .. $n );
my ( $trailing_zeroes ) = ( $fact =~ m/(0+)$/ );
my $trailing_zero_count = defined( $trailing_zeroes ) ? length( $trailing_zeroes ) : 0;

print "$trailing_zero_count ($n! = $fact)\n";
