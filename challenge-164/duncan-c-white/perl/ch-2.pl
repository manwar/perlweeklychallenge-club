#!/usr/bin/perl
# 
# TASK #2 - Happy Numbers
# 
# Write a script to find the first 8 Happy Numbers in base 10. For more
# information, please check out https://en.wikipedia.org/wiki/Happy_number
# 
# Starting with any positive integer, replace the number by the sum of the
# squares of its digits, and repeat the process until the number equals 1
# (where it will stay), or it loops endlessly in a cycle which does not
# include 1.
# 
# Those numbers for which this process end in 1 are happy numbers, while
# those numbers that do not end in 1 are unhappy numbers.
# 
# Example
# 
# 19 is a Happy Number in base 10, as shown:
# 
# 19 => 1^2 + 9^2
#    => 1   + 81
#    => 82 => 8^2 + 2^2
#          => 64  + 4
#          => 68 => 6^2 + 8^2
#                => 36  + 64
#                => 100 => 1^2 + 0^2 + 0^2
#                       => 1 + 0 + 0
#                       => 1
# 
# MY NOTES: seems very easy.  Loop detection is surely just a set of values
# that we've already seen.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-2.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
use Data::Dumper;
use List::Util qw(sum0);

my $debug=0;
die "Usage: happy-numbers [--debug] firstN\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $firstn = shift;

=pod

=head2 my $ishappy = ishappy( $x );

Return 1 iff $x is a happy number (in base 10), otherwise return 0.

=cut
fun ishappy( $x )
{
	my %seen;
	while( $x > 1 )
	{
		return 0 if $seen{$x}++;
		#say "debug: x=$x" if $debug;
		$x = sum0( map { $_ * $_ } split(//,$x) );
	}
	return 1;
}

#say ishappy( 19 );
my $nfound = 0;
for( my $n=1; $nfound<$firstn; $n++ )
{
	my $ishappy = ishappy($n);
	if( $debug )
	{
		my $str = $ishappy?"":"un";
		say "$n is ${str}happy";
	}
	next unless $ishappy;
	$nfound++;
	say "$n is happy number #${firstn}" if $nfound==$firstn;
}
