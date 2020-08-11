use v6;

################################################################################
=begin comment

Perl Weekly Challenge 020
=========================

Task #1
-------
Write a script to accept a string from command line and split it on change of
character. For example, if the string is *"ABBCDEEF"*, then it should split like
*"A"*, *"BB"*, *"C"*, *"D"*, *"EE"*, *"F"*.

=end comment
################################################################################

#--------------------------------------#
# Copyright © 2019 PerlMonk Athanasius #
#--------------------------------------#

my Str constant $DEFAULT = 'ABBCDEEF';

sub MAIN(Str:D $string = $DEFAULT)
{
    my @matches    = $string ~~ m:g/ ( (.) $0* ) /;
    my @substrings = @matches.map( { '"' ~ .Str ~ '"' } );

    say "\nOriginal string:      \"$string\"\n",
        "After splitting on\nchanges of character: ", join(', ', @substrings);
}

################################################################################
