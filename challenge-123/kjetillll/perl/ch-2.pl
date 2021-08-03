#!/usr/bin/env perl

#Returns true if four points form a square.

# is_square( [10,20], [20,20], [20,10], [10,10] )  #return 1 (true)
# is_square( [2,6], [5,1], [0,-2], [-3,3] )        #return 1 (true)

# perl ch-2.pl 2,6 5,1 0,-2 -3,3     #prints 1

sub is_square {
    die if @_ != 4 or grep@$_!=2,@_;
    my %dsf;   #dsf=distance squared found
    for my $p1 ( 0     .. 2 ){       # for the three first points
    for my $p2 ( $p1+1 .. 3 ){       # loop through the rest of the points
	my($p1x,$p1y,$p2x,$p2y)=(@{$_[$p1]},@{$_[$p2]});
	$dsf{ ($p1x-$p2x)**2 + ($p1y-$p2y)**2 }++; #register distance squared
    }}
    #If only two different distances found between any two points it means
    #they form a square, returns 1 (true) if so, or 0 (false) otherwise.
    #Counting distances squared saves having to do square root as in Pythagoras
    #grep > 0 prevents two pairs of duplicate points or four equal points from returning true
    2==(grep$_>0,keys%dsf) ? 1 : 0
}

print is_square( map[split/,/],@ARGV ), "\n";
