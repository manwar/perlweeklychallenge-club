### /* https://theweeklychallenge.org/blog/perl-weekly-challenge-172/
### 
### Task 2: Five-number Summary
### 
### Submitted by: [51]Mohammad S Anwar
###      __________________________________________________________________
### 
###    You are given an array of integers.
### 
###    Write a script to compute the five-number summary of the given set of
###    integers.
### 
###    You can find the definition and example in the [52]wikipedia page.
### */
### /*
### lower and upper quartile using Method 1 mentioned in https://en.wikipedia.org/wiki/Quartile#Discrete_distributions
### 
### Computing methods
### Discrete distributions
### For discrete distributions, there is no universal agreement on selecting the quartile values.[3]
### 
### Method 1
### 
### 1) Use the median to divide the ordered data set into two-halves.
###  If there is an odd number of data points in the original ordered data set, do not include the median (the central value in the ordered list) in either half.
###  If there is an even number of data points in the original ordered data set, split this data set exactly in half.
### 
### 2) The lower quartile value is the median of the lower half of the data. The upper quartile value is the median of the upper half of the data.
### 
### This rule is employed by the TI-83 calculator boxplot and "1-Var Stats" functions.
### */
use strict;
use warnings;

die "please provide integers to calculate five-number summary" unless @ARGV && join(" ",@ARGV) =~ /^\d+(\s\d+)*$/;
my @a = sort{$a <=> $b} @ARGV;

printf "Input: (%s)\n", join(", ",@a);
my @fn = ($a[-1], @a==1 ? $a[0] : median(@a[int(@a/2)+@a%2..$#a]), median(@a), @a==1 ? $a[0] : median(@a[0..int(@a/2)-1]), $a[0]);
my $i = 5;
foreach (qw/sample_minimum lower_quartile median upper_quartile sample_maximum/){
	printf "%s: %s\n", $_, $fn[--$i];
}

sub median{
	return @_ % 2 ? $_[int(@_/2)] : ($_[@_/2-1] + $_[@_/2])/2;
}
