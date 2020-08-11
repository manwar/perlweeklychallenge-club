#
# Perl Weekly Challenge - 031
# Task #2
#
# Mark Senn, http://engineering.purdue.edu/~mark
# October 25, 2019
#
# From
# https://perlweeklychallenge.org/blog/perl-weekly-challenge-031#task-2
#     Create a script to demonstrate creating dynamic variable name,
#     assign a value to the variable and finally print the variable.
#     The variable name would be passed as command line argument.
#
# Perl 6 is in the process of being renamed Raku.
# Run using Raku v6.d;
use v6.d;

sub MAIN($name, $value)
{
    say "$name    $value";

    # Using
    #     my $$name = $value;
    # gave
    #     Cannot declare a variable by indirect name (use a hash instead?)
    #
    # Using
    #     ${$name} = $value;
    # gave
    #     Unsupported use of ${$name}; in Perl 6 please use $($name) for hard ref
    #     or $::($name) for symbolic ref
    #
    # Using
    #     my $::($name);
    # gave
    #     Cannot declare a variable by indirect name (use a hash instead?)
    my %hash;
    %hash{$name} = $value;
    %hash{$name}.say;
}
