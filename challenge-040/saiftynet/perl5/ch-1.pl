#!/usr/env perl
# Perl Challenge 040 Task 1
# Non-destructively print contents of two or more arrays at a given index.

use feature "say";
my @arraysList=(                  # array containing 2 or more arrays (as anon array refs)
    [qw{I L O V E Y O U }],
    [qw{2 4 0 3 2 0 1 9 }],
    [qw{! ? £ $ % ^ & * }],
    );

say "Without an index list";
printAtIndex(\@arraysList);                   # call routine with no indices 

say "\nWith a single index passed";
printAtIndex(\@arraysList, 5);                # call routine with a single index

say "\nWith a multiple indices passed";
printAtIndex(\@arraysList, [3,2,1,4]);        # call routine with list of indices

sub printAtIndex{

    my ($arrays,$indices)=@_;
    
    $indices//=[0..$#{@$arrays[0]}];           # if indices not specified make list of all indices
    
    $indices=[$indices] unless (ref $indices); # if index passed as scalar convert to arrayRef
    
    foreach my $index (@$indices){             # for each index provided..
    
       foreach my $array (@arraysList){        # for each array in the list
       
          print $$array[$index]," ";           # print indexed contents of these arrays
          
       };
       print "\n";                             # next line
    };
}
