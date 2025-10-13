#!/usr/bin/env raku
use Test;

is zero-friend(4, 2, -1, 3, -2),          1;
is zero-friend(-5, 5, -3, 3, -1, 1),      1;
is zero-friend(7, -3, 0, 2, -8),          0;
is zero-friend(-2, -5, -1, -8),           1;
is zero-friend(-2, 2, -4, 4, -1, 1),      1;

is zero-friend-alt(4, 2, -1, 3, -2),     -1;
is zero-friend-alt(-5, 5, -3, 3, -1, 1),  1;
is zero-friend-alt(7, -3, 0, 2, -8),      0;
is zero-friend-alt(-2, -5, -1, -8),      -1;
is zero-friend-alt(-2, 2, -4, 4, -1, 1),  1;

sub zero-friend(+@nums)
{
    @nums.classify({ .sign }, :as{ .abs }) 
         .values
         .flat(:hammer)
         .min 
}

# I think this alternate solution matches the instructions better.
# I meant to email Mohammad for clarification before the deadline
# but I forgot.

sub zero-friend-alt(+@nums)
{
    my %c := { -1 => [], 0 => [], 1 => [] }
    %c = @nums.classify: { .sign }, :into(%c);  
    (%c<-1>.max, %c<0>.min, %c<1>.min).sort({ .abs, -.sign }).head
}
