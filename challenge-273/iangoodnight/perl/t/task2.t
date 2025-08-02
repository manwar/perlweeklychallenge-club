use strict;
use warnings;
use autodie;
use Test::More;

use lib qw( . );

use task2 qw(b_after_a);

subtest 'Examples' => sub {
    plan tests => 4;

    is( b_after_a('aabb'), 1, 'Example 1' );
    is( b_after_a('abab'), 0, 'Example 2' );
    is( b_after_a('aaa'),  0, 'Example 3' );
    is( b_after_a('bbb'),  1, 'Example 4' );
};

subtest 'Additional tests' => sub {
    plan tests => 3;

    is( b_after_a('abbc'), 1, 'Characters other than "a" after "b"' );
    is( b_after_a(2),      0, 'Input other than strings' );
    is( b_after_a(),       0, 'No input' );
};

done_testing();
