#! /opt/local/bin/perl
#
#       balanced_brackets.pl
#
#       PWC 42 - TASK #2
#             Balanced Brackets
#             Write a script to generate a string with random number of ( and )
#             brackets. Then make the script validate the string if it has
#             balanced brackets.
#
#             For example:
#
#             () - OK
#             (()) - OK
#             )( - NOT OK
#             ())() - NOT OK
#
#       method: to make the random string of parens, we take a range of 1 to
#             10 indexes and, mapping through them, assign either a left or right
#             paren and place on a list, joining that list at the end to make a
#             single string. So far so good.
#
#             For validation, we will match pairs of parens and eliminate them
#             from the string until no more can be matched. If our string goes
#             away we were good, if not, then things didn't match up. That said,
#             there are a number of short circuits to this process where it no
#             longer pays to continue.
#
#             • Matched parens come in pairs, by definition, so right out of the
#             gate the length of the random string must be even. So this
#             eliminates one half of the chances. We will check for evenness and
#             exit with a message as required.
#
#             • If the string under consideration starts with a right paren, that
#             paren can no longer be matched and the validation will fail. One way
#             to detect this is to look for the placement of a valid () match; if
#             the match does not take place at index 0, there must be a paren
#             preceeding it and that paren must be a right paren. So we exit with
#             a note.
#
#             • Finally if matching has stopped we check for length, if the string
#             still has chars, it is imbalanced and we exit with a note, showing
#             the unbalanced section. If we have no string lenght remaining,
#             against all odds we have succeded at randomly crafting a balanced
#             string of parens.
#
#             It's obvious this last occurance will in fact rarely happen. The
#             shortest matching sting is 2 chars, (). The odds are .5 any given
#             string is odd-numbered, and .5 the first paren will be right, so our
#             chance of immediately failing is .75
#
#             After this the odds get complicated, but never better, and worse as
#             the length of the random base grows. So for purposes of this
#             experiment the length has been limited to up to 10 chars.

#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN

my $upper = shift @ARGV // 10;
$upper = int(rand($upper)) + 1;

my $str = make_string($upper);
say $str;
say validate( $str );


## ## ## ## ## SUBS

sub make_string {
    return join '', map { ['(',')']->[int(rand(2))] } (1..$_[0]);
}

sub validate {
    my $str = shift;
    unless (length($str)%2==0) { return "IMBALANCED - odd number of parens"};
    while ( $str =~ s/ \( (.*?) \) /$1/x) {
        if ($-[0] != 0){ return "IMBALANCED - remaining group starts with right paren : $str" }
    }
    return (length $str == 0) ? "BALANCED" : "IMBALANCED - $str remaining";
}
