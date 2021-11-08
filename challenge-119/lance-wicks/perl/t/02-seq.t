use Test2::V0 -target => Sequence;

is $CLASS->no_one_on_one(5),  13,   "Example 1";
is $CLASS->no_one_on_one(10), 32,   "Example 2";
is $CLASS->no_one_on_one(60), 2223, "Example 3";

done_testing;
