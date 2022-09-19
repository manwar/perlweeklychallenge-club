#!/usr/bin/perl
# 
# TASK #1 - Prime Palindrome
# 
# Write a script to find all prime numbers less than 1000, which are also
# palindromes in base 10. Palindromic numbers are numbers whose digits
# are the same in reverse. For example, 313 is a palindromic prime, but
# 337 is not, even though 733 (337 reversed) is also prime.
# 
# MY NOTES: ok.  Pretty easy.
# 
# GUEST LANGUAGE: As a bonus, I also had a go at translating ch-1.pl
# into C (look in the C directory for that).
# 

use strict;
use warnings;
use feature 'say';
use Getopt::Long;
use Function::Parameters;
#use Data::Dumper;

use lib qw(.);
use MakePrimes;

my $debug=0;
die "Usage: prime-palindromes [--debug] UpToN\n"
	unless GetOptions( "debug"=>\$debug ) && @ARGV==1;
my $n = shift;

my @primes = primes_upto( $n );

=pod

=head2 my $ispal = ispalindrome( $x );

Return 1 iff $x is palindromic in base 10, otherwise 0.

=cut

fun ispalindrome( $x )
{
	return $x eq reverse($x) ? 1 : 0;
}

say "Palindromic primes up to $n";
say for grep { ispalindrome($_) } @primes;
