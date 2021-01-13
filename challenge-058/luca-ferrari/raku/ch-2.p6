#!env raku
#
# Perl Weekly Challenge 58
#
# Task 2
#
# Write a script to arrange people in a lineup according to how many taller people are in front of each person in line. You are given two arrays. @H is a list of unique heights, in any order. @T is a list of how many taller people are to be put in front of the corresponding person in @H. The output is the final ordering of people’s heights, or an error if there is no solution.

#     Here is a small example:

#     @H = (2, 6, 4, 5, 1, 3) # Heights
#     @T = (1, 0, 2, 0, 1, 2) # Number of taller people in front

#     The ordering of both arrays lines up, so H[i] and T[i] refer to the same person. For example,
#     there are 2 taller people in front of     the person with height 4, and there is 1 person in front of the person with height 1.
#
# As per the last diagram, your script would then output the ordering (5, 1, 2, 6, 3, 4) in this case. (The leftmost element is the “front” of the array.)

sub MAIN(){
    my @H = 2, 6, 4, 5, 1, 3;
    my @T = 1, 0, 2, 0, 1, 2;


    # build an hash to map heights to tallers
    my %HT;
    for 0 ..^ @H.elems {
        %HT{ @H[ $_ ] } = @T[ $_ ];
    }


    # evaluate all possible solutions
    for %HT.keys.permutations -> @solution {
        # the leftmost element must have a taller set to zero!
        next if %HT{ @solution[ 0 ] } != 0;

        # the solution is good if the number of tallers for
        # every element is equal to the values of tallers
        my $ok = True;

        for 1 ..^ @solution.elems {
            my $height  = @solution[ $_ ];
            my $tallers = %HT{ $height };
            $ok = False if @solution[ 0 .. $_-1].grep( * > $height ) != $tallers;
            last if ! $ok;
        }

        say @solution if $ok;
    }
}
