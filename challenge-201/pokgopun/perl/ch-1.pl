use strict;
use warnings;

@ARGV = (0,1,3) unless join("",@ARGV) =~ /^\d+$/; ### default array to example1 if not provided via arguments

my %seen;
foreach (@ARGV){
	die "not an array of unique numbers" if $seen{$_}++;
}

printf "Input: array = %s\nOutput: %s\n", join(", ", sort{$a<=>$b} @ARGV), join(", ", grep{!$seen{$_}} 0..$#ARGV+1);
