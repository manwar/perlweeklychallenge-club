use strict;
use warnings;
use autodie;

use Readonly;
use Test::More;

use lib qw( . );

use Task1 qw(percentage_of_character);

Readonly::Scalar my $EMPTY_STR => q{};

subtest 'Examples' => sub {
    plan tests => 6;

    is( percentage_of_character( 'perl',      'e' ), 25, 'Example 1' );
    is( percentage_of_character( 'java',      'a' ), 50, 'Example 2' );
    is( percentage_of_character( 'python',    'm' ), 0,  'Example 3' );
    is( percentage_of_character( 'ada',       'a' ), 67, 'Example 4' );
    is( percentage_of_character( 'ballerina', 'l' ), 22, 'Example 5' );
    is( percentage_of_character( 'analitik',  'k' ), 13, 'Example 6' );
};

subtest 'Additional tests' => sub {
    plan tests => 7;

    is( percentage_of_character( 'perl', 'x' ), 0, 'Character not found' );
    is( percentage_of_character( 'perl', 2 ),   0, 'Input other than strings' );
    is( percentage_of_character( 2, 'e' ),      0, 'Input other than strings' );
    is( percentage_of_character( $EMPTY_STR, 'e' ),    0, 'Empty string' );
    is( percentage_of_character( 'perl', $EMPTY_STR ), 0, 'Empty character' );
    is( percentage_of_character('perl'), 0, 'No character argument' );
    is( percentage_of_character(),       0, 'No input' );
};

done_testing();
