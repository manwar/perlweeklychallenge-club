use Test2::V0 -target => 'Nibble';

my @tests = ( [ 101, 86 ], [ 18, 33 ] );

for (@tests) {
    is $CLASS->swap( $_->[0] ), $_->[1], "$_->[0] returns $_->[1]";
}

done_testing;
