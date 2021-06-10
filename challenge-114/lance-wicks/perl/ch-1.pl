use Test2::V0 -target => 'Palindrome';

my @cases
    = ( [ 1, 2 ], [ 9, 11 ], [ 99, 101 ], [ 999, 1001 ], [ 1234, 1331 ], );

for my $pair (@cases) {
    my $got = $CLASS->num( $pair->[0] );
    is $got, $pair->[1], "$pair->[0] \t Expect: $pair->[1] \t\t Got: $got";

}

done_testing;
