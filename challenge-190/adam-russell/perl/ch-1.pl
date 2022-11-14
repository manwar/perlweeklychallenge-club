use v5.36;
use strict;
use warnings;
##
# You are given a string with alphabetic characters only: A..Z and a..z.
# Write a script to find out if the usage of Capital is appropriate if it 
# satisfies at least one of the following rules:
#    1) Only first letter is capital and all others are small.
#    2) Every letter is small.
#    3) Every letter is capital.
##
use boolean;

sub capital_detection{
    {my($s) = @_; return true if length($s) == $s =~ tr/A-Z//d;}
    {my($s) = @_; return true if length($s) == $s =~ tr/a-z//d;}
    {
        my($s) = @_; 
        $s =~ m/(^.{1})(.*)$/;
        my $first_letter = $1;
        my $rest_letters = $2;
        return true if $first_letter =~ tr/A-Z//d == 1 &&
                       length($rest_letters) == $rest_letters =~ tr/a-z//d;
    }
    return false;
}

MAIN:{
    say capital_detection(q/Perl/);
    say capital_detection(q/TPF/);
    say capital_detection(q/PyThon/);
    say capital_detection(q/raku/);
}