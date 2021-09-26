use strict;
use warnings;
##
# You are given a sorted list of unique positive integers.
# Write a script to return list of arrays where the arrays 
# are consecutive integers.
##
use Data::Dump q/pp/;

sub consecutive_arrays{
    my @arrays=([]);
    my $a = 0;
    my $x = shift;
    {
        if(!@{$arrays[$a]}){
            push @{$arrays[$a]}, $x;
        }
        else{
            my $y = $arrays[$a]->[@{$arrays[$a]} - 1];
            if($x == $y + 1){
                push @{$arrays[$a]}, $x;
            }
            else{
                push @arrays, [$x];
                $a+=1;
            }
        }
        $x = shift;
        redo if $x;
    }
    return @arrays;
}

MAIN:{
    print pp consecutive_arrays(1, 2, 3, 6, 7, 8, 9);
    print "\n";
    print pp consecutive_arrays(11, 12, 14, 17, 18, 19);
    print "\n";
    print pp consecutive_arrays(2, 4, 6, 8);
    print "\n";
    print pp consecutive_arrays(1, 2, 3, 4, 5);
    print "\n";
}