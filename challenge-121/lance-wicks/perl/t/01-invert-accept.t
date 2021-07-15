use Test2::V0 -target => 'Invert';
use Test::Output;

subtest 'Testing the script output' => sub {
    require './ch-1.pl';

    stdout_is { &run( 12, 3 ) }
    "Input: \$m = 12, \$n = 3\nOutput: 8\n", 'Example 1';

    stdout_is { &run( 18, 4 ) }
    "Input: \$m = 18, \$n = 4\nOutput: 26\n", 'Example 2';
};

subtest 'Invert::bit' => sub {
    is $CLASS->bit( m => 12, n => 3 ), 8, 'Example one';

    is $CLASS->bit( m => 18, n => 4 ), 26, 'Example two';
};

done_testing;
