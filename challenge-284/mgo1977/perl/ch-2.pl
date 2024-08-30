#!/bin/perl -w


# Task 2: Relative Sort
# Submitted by: Mohammad Sajid Anwar
# You are given two list of integers, @list1 and @list2. The elements in the @list2 are distinct and also in the @list1.

# Write a script to sort the elements in the @list1 such that the relative order of items in @list1 is same as in the @list2. Elements that is missing in @list2 should be placed at the end of @list1 in ascending order.

# Example 1
# Input: @list1 = (2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5)
#        @list2 = (2, 1, 4, 3, 5, 6)
# Ouput: (2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9)

# Example 2
# Input: @list1 = (3, 3, 4, 6, 2, 4, 2, 1, 3)
#        @list2 = (1, 3, 2)
# Ouput: (1, 3, 3, 3, 2, 2, 4, 4, 6)

# Example 3
# Input: @list1 = (3, 0, 5, 0, 2, 1, 4, 1, 1)
#        @list2 = (1, 0, 3, 2)
# Ouput: (1, 1, 1, 0, 0, 3, 2, 4, 5)



testMe(\&process, 'Example1', [2, 3, 9, 3, 1, 4, 6, 7, 2, 8, 5], [2, 1, 4, 3, 5, 6], [2, 2, 1, 4, 3, 3, 5, 6, 7, 8, 9]);
testMe(\&process, 'Example2', [3, 3, 4, 6, 2, 4, 2, 1, 3], [1, 3, 2], [1, 3, 3, 3, 2, 2, 4, 4, 6]);
testMe(\&process, 'Example3', [3, 0, 5, 0, 2, 1, 4, 1, 1], [1, 0, 3, 2], [1, 1, 1, 0, 0, 3, 2, 4, 5]);



sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $input2 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1, $input2);

    if ( areEquals($got, $expectedValue) ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got=@$got, expectedValue=@$expectedValue\n";
    }

}

sub areEquals {
    my $a1 = shift;
    my $a2 = shift;

    if ( @$a1!=@$a2 ) {
        return 0;
    }

    for(my $i=0; $i<@$a1; ++$i) {

        if ( $a1->[$i] != $a2->[$i] ) {
            return 0;
        }

    }


    return 1;
}

sub process {
    my $input1 = shift;
    my $input2 = shift;

    my $positionMap = {};

    for(my $i=0; $i <@$input2; ++$i) {
        $positionMap->{ $input2->[$i] } = $i;
    }

    my @found;
    my @missed;

    foreach my $el ( @$input1 ) {
        
        if ( not exists $positionMap->{$el} ) {
            push(@missed, $el);
        }
        else {
            push(@found, $el);
        }


    }

    my @result = ( 
        ( sort { $positionMap->{$a} <=> $positionMap->{$b} } @found ), 
        ( sort { $a <=> $b } @missed) 
    );

    return \@result;

}

