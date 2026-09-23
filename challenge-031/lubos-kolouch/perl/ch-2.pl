#!/usr/bin/env perl
use v5.38;
use warnings;
use Test::More;

# Task 2: Create a script to demonstrate creating dynamic variable name,
# assign a value to the variable and finally print the variable.

sub assign_variable ( $var_name, $val = 'test' ) {
    no strict 'refs';    ## no critic (TestingAndDebugging::ProhibitNoStrict)

    ${$var_name} = $val;
    return ${$var_name};
}

# Run via CLI if arguments are supplied
if ( @ARGV ) {
    my $name = $ARGV[0];
    my $val  = $ARGV[1] // 'test';
    assign_variable( $name, $val );
    no strict 'refs';    ## no critic (TestingAndDebugging::ProhibitNoStrict)
    say "Assigned \$$name = ${$name}";
}

# TESTS
subtest 'Dynamic variable assignment' => sub {
    my $test_var = 'my_dynamic_var';
    my $res      = assign_variable( $test_var, 'hello_world' );
    is( $res, 'hello_world', 'Returned assigned value' );

    no strict 'refs';    ## no critic (TestingAndDebugging::ProhibitNoStrict)
    is( ${$test_var}, 'hello_world', 'Variable value in symbol table matches' );
};

done_testing;
