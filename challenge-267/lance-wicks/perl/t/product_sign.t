use Test2::V0 -target => 'Product::Sign';

# Input: @ints = (-1, -2, -3, -4, 3, 2, 1)
# Output: 1

my @ints = ( -1, -2, -3, -4, 3, 2, 1 );
is $CLASS->calc(@ints), 1, 'Example one should return 1';

@ints = ( 1, 2, 0, -2, -1 );
is $CLASS->calc(@ints), 0, 'Example two should return 0';

@ints = ( -1, -1, 1, -1, 2 );
is $CLASS->calc(@ints), -1, 'Example three should return -1';

done_testing;
