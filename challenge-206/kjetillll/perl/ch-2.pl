#!/usr/bin/perl
use warnings; use strict;
#use Acme::Tools;

my @array = @ARGV;                #input from command line args
@array = (1,2,3,4) if not @array; #...or use test case
#@array = (0,2,1,3) if not @array; #...or use test case

print "Input: @array\n";
print "Max sum: ", maxsum(@array), "\n";


sub maxsum {
    my $max;
    for my $perm_array ( perm(@_) ){
	my $sum;
	while(@$perm_array){  #loop the pairs ($a,$b) of current permutation
	    my($a,$b) = splice@$perm_array,0,2;
	    $sum += $a<$b ? $a : $b;
	}
	$max = $sum if !defined$max or $sum>$max;
    }
    $max
}

sub perm {
  my(@i,@r) = 0..$#_;
  @_ || return;
  while ( push @r, [@_[@i]] ) {
    my $p = $#i || last;
    --$p || last while $i[$p-1] > $i[$p];
    push @i, reverse splice @i, my$q=$p;
    ++$q while $i[$p-1] > $i[$q];
    @i[$p-1,$q] = @i[$q,$p-1];
  }
  @r
}
