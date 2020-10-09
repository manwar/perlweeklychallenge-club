#!/usr/bin/perl 
#===============================================================================
#
#         FILE: ch-1.pl
#
#        USAGE: ./ch-1.pl  
#
#  DESCRIPTION: Perl Weekly Challenge 081
#  				https://perlweeklychallenge.org/blog/perl-weekly-challenge-081/
#  				Task 1 - Common base string 
#
#      OPTIONS: ---
# REQUIREMENTS: ---
#         BUGS: ---
#        NOTES: ---
#       AUTHOR: YOUR NAME (), 
# ORGANIZATION: 
#      VERSION: 1.0
#      CREATED: 10/09/2020 10:43:10 AM
#     REVISION: ---
#===============================================================================

use strict;
use warnings;


sub get_common_strings {
	my $arg = shift;

	my $str1 = $arg->{str1};
	my $str2 = $arg->{str2};

	my @result;

	my ($res1) = $str1 =~ /(.*)\1+/;
	push @result, $res1;

	my ($res2) = $str2 =~ /(.*)\1+/;
	push @result, $res2 unless $res1 eq $res2;

	return \@result;

}

use Test::More;

is_deeply(get_common_strings({str1 => 'abcdabcd', str2 => 'abcdabcdabcdabcd'} ),['abcd','abcdabcd']);
is_deeply(get_common_strings({str1 => 'aaa', str2 => 'aa'} ),['a']);
is_deeply(get_common_strings({str1 => 'abc', str2 => 'aa'} ),['','a']);

