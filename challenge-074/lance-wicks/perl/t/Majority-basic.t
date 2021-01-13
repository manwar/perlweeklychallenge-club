use Test2::V0 -target => 'Majority';

ok 1;
#Example 1
#Input: @A = (1, 2, 2, 3, 2, 4, 2)
#Output: 2, as 2 appears 4 times in the list which is more than floor(7/2).
subtest 'Example 1' => sub {
    my @A = ( 1, 2, 2, 3, 2, 4, 2 );
    is $CLASS->element(@A), 2;

};

#Example 2
#Input: @A = (1, 3, 1, 2, 4, 5)
#Output: -1 as none of the elements appears more than floor(6/2).
subtest 'Example 2' => sub {
    my @A = ( 1, 3, 1, 2, 4, 5 );
    is $CLASS->element(@A), -1;

};

done_testing;
