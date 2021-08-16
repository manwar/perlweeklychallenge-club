#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @integers = (5, 13, 1, 100);
my $integer;
my $list;

foreach $integer (@integers){
    print($integer, ":\n");
    $list = pythagorean_triples($integer);
    if(defined($list)){
        foreach(@{$list}){
            printf(
                "    %s\n",
                list_contents_to_string(@{$_})
            );
        }
    } else{
        print("    -1\n");
    }
    print("\n");
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Calculate the Pythagorean triples associated with an integer N, if any exist,
# including numbers up to 10000, e.g. (a, b, N), (N, b, c) or (a, N, c) where
# the three numbers in the triple satisfy Pythagorean's Theorem
# (a^2 + b^2 == c^2)
# Takes one argument:
# * The integer (N)
# Returns on success:
# * A ref to an array of Pythagorean triples, which are themselves refs to
#   arrays, e.g.:
#   [ [3, 4, 5], [5, 12, 13] ]
# Returns on failure:
# * undef if no Pythagorean triples could be found
################################################################################
sub pythagorean_triples{
    my $n = int(shift());

    my $i;
    my $num;
    my $n2 = $n ** 2;
    my @triples;

    # Find triplets where $n is the
    # hypotenuse
    for($i=2; $i<=int($n/2)+1; $i++){
        $num = sqrt($n2 - $i ** 2);
        if($num == int($num)){
            if($i < $num){
                push(@triples, [$i, $num, $n]);
            } else{
                push(@triples, [$num, $i, $n]);
            }
        }

    }

    # Find triplets where $n is one
    # of the other two sides
    for($i=2; $i<10000; $i++){
        $num = sqrt($n2 + $i ** 2);
        if($num == int($num)){
            if($i < $n){
                push(@triples, [$i, $n, $num]);
            } else{
                push(@triples, [$n, $i, $num]);
            }
        }
    }

    if(scalar(@triples)){
        return(\@triples);
    } else{
        return(undef);
    }

}



################################################################################
# Produce a string detailing the contents of a list 
# Takes one argument:
# * A list of references to lists; the list must contain at least one element,
#   e.g.:
#   @list = (1, 3, 2, 7);
#   list_contents_to_string(@list);
# Returns on success:
# * A string representation of the set of lists provided, e.g.:
#   "(1, 3, 2, 7)"
# Returns on error:
# * undef if the provided list is empty
################################################################################
sub list_contents_to_string{

    return(undef) unless(defined($ARG[0]));

    return(
        sprintf(
            "(%s)",
            join(", ", @ARG)
        )
    );

}



