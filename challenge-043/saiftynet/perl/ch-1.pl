#!/usr/env perl
# Perl Challenge Script
# Olympics 5 intersecting rings have  some numbers allocated as below:
# Blue: 8, Yellow: 7, Green: 5, Red: 9, Back "?". Write a script to
# place numbers in the intersections and in the black ring so that
# the sum of numbers in each ring is exactly 11.

# list of known numbers in a chain of rings.
my @list=(9,"?",5,"?","?","?",7,"?",8);

# hash contains which positions in the chain correspond to which ring colour 
my %rings=(red=>[0,1],
           green=>[1,2,3],
           black=>[3,4,5],
           yellow=>[5,6,7],
           blue=>[7,8],
           );

print "Inital state:-\n";
displayRings();

my $fixed=0;                               
my $pass=0;

# this function solves in one pass if we fix in
# the sequence blue red green yellow black but
# that would be cheating

while (not $fixed){
	$fixed=1;
	foreach my $ring (keys %rings){
	   my $sum=0; my @missing=();
	   # count missing, sum known numbers
	   foreach my $pos (@{$rings{$ring}}){
		   if ($list[$pos] eq"?"){
			   push @missing,$pos
			   }
		   else {
			   $sum+=$list[$pos]
			   }
	   }
	   if (scalar @missing == 1){
		   # if only one missing number then the missing
		   # number is 11 - the sum of known numbers
		   $list[$missing[0]]=11-$sum;
	   }
	   elsif (scalar @missing){
		   # if still missing numbers then not yet fixed 
		   $fixed=0   
	   }
	}
	$pass++;
	print $fixed?"Final state:-\n":"Pass $pass\n";
    displayRings();
}

sub displayRings{
    printf  (
"     RED %s                 BLACK %s                     BLUE %s
        RedGrn %s    GrnBlk %s     BlkYel %s      YelBlu %s
               GREEN %s                  YELLOW %s\n",
               @list[0,4,8,1,3,5,7,2,6]
        );	
	
}

