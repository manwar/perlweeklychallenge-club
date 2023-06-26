#!usr/bin/perl
use v5.36;

=Challenge 220 - 2 - Last Member=


You are given an array of positive integers, @ints.

Write a script to find the last member if found otherwise return 0. 
Each turn pick 2 biggest members (x, y) then decide based on the following conditions, 
continue this until you are left with 1 member or none.

a) if x == y then remove both members
b) if x != y then remove both members and add new member (y-x)

=cut


lastMember(2, 7, 4, 1, 8, 1);       # 1
lastMember(1);                      # 1
lastMember(1, 1);                   # 0

sub lastMember(@list)
{
    while(1 < @list )
    {
        @list = sort @list;
        
        # remove the two biggest elements
        my $y = pop(@list);
        my $x = pop(@list);
        
        # add new member (y-x)
        push(@list, $y - $x)    if( $x != $y);

    }
    
    push(@list, 0)  if(@list == 0);     # we have to say 0 if the array is empty
    say @list;
}