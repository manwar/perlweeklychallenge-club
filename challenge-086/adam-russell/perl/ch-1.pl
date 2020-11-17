use strict;
use warnings;
##
# You are given an array of integers @N and an integer $A.
# Write a script to find find if there exists a pair of elements 
# in the array whose difference is $A.
# Print 1 if exists otherwise 0.
##
use boolean;
use Math::Combinatorics;

sub build_constraints{
    my @constraints;
    my $a_not_equal_b = sub { $_[0] != $_[1] };
    my $difference_equal_n = sub { $_[0] - $_[1] == $_[2] };
    return (
       $a_not_equal_b,
       $difference_equal_n
    );
}

MAIN:{
    my $combinations = Math::Combinatorics->new(
                           count => 2,
                           data => [@ARGV[1 .. @ARGV - 1]],
                       );
    my $found = false;  
    my ($check_equal, $check_difference) = build_constraints();           
    while(my @combination = $combinations->next_combination()){  
        if($check_equal->(@combination) && $check_difference->(@combination, $ARGV[0])){
            $found = true;
            print "1\n"; last;
        }
    }
    print "0\n" if(!$found);
}