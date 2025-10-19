use Test2::V0;

require './ch-1.pl';

is zero_friend(4,2,-1,3,-2),    1;
is zero_friend(-5,5,-3,3,-1,1), 1;
is zero_friend(7,-3,0,2,8),     0;
is zero_friend(-2,-5,-1,-8),    1;
is zero_friend(-2,2,-4,4,-1,1), 1;
is zero_friend(2,-2,4,-4,1,-1), 1;

done_testing;
