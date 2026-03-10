#!/usr/bin/perl

use strict;
use warnings;
use English;

################################################################################
# Begin main execution
################################################################################

my @strings = (
    "G()(al)",
    "G()()()()(al)",
    "(al)G(al)()()",
    "()G()G",
    "(al)(al)G()()"
);

print("\n");
foreach my $string (@strings){
    printf(
        "Input: \$str = \"%s\"\nOutput: \"%s\"\n\n",
        $string,
        goal_parser($string)
    );
}

exit(0);
################################################################################
# End main execution; subroutines follow
################################################################################



################################################################################
# Given a string, act as a Goal Parser on it- that is to say, interpret tokens
# within the string as follows:
# * 'G' is interpreted as 'G' 
# * '()' is interprerted as 'o'
# * '(al) is interprted as 'al'
# Takes one argument:
# * The string to be parsed (e.g. "(al)G(al)()()")
# Returns:
# * The interpreted string that results from the parsed input (e.g. "alGaloo")
################################################################################
sub goal_parser{
    my $string = shift();

    # Substitute all the parenthetical tokens;
    # G's pass through as-is
    $string =~ s/\(\)/o/g;
    $string =~ s/\(al\)/al/g;

    return($string);

}



