use Test2::V0 -target => Maxgap;

my @example1 = (2, 9, 3, 5);
my $expected1 = 4;

is $CLASS->maxgap(@example1), $expected1, 'Example 1';

my @example2 = (1, 3, 8, 2, 0);
my $expected2 = 5;

is $CLASS->maxgap(@example2), $expected2, 'Example 2';


my @example3 = (5);
my $expected3 = 0;

is $CLASS->maxgap(@example3), $expected3, 'Example 3';

done_testing;
