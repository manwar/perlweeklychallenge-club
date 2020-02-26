use v6;

#
#       balanced_brackets.p6
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
#       method :For validation, we will match pairs of parens and eliminate them
#             from the string until no more can be matched. If our string goes
#             away we were good, if not, then things didn't match up. That said,
#             there is one short circuit to this process where it no
#             longer pays to continue.
#
#             • Matched parens come in pairs, by definition, so right out of the
#             gate the length of the random string must be even. So this
#             eliminates one half of the chances. We will check for evenness and
#             exit with a message as required.
#
#             Finally if matching has stopped we check for length, if the string
#             still has chars, it is imbalanced and we exit with a note, showing
#             the unbalanced section. If we have no string lenght remaining,
#             against all odds we have succeded at randomly crafting a balanced
#             string of parens.
#
#             It's obvious this last occurance will in fact rarely happen. The
#             shortest matching sting is 2 chars, (). The odds are .5 any given
#             string is odd-numbered, and .5 the first paren will be right, hence unmatchable, so our
#             chance of immediately failing is .75
#
#             After this the odds get complicated, but never better, and worse as
#             the length of the random base grows. So for purposes of this
#             experiment the length has been limited to up to 10 chars.
#
#             As is, it isn't a very fun game as one almost always loses.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##

sub MAIN ( Int:D $upper_bound where {$upper_bound > 1} = 10) {
    my $str_length = (^$upper_bound).pick + 1;
    my $str = make_string( $str_length );

    say "start: $str";
    say "val: ", validate( $str );

}


## ## ## ## ## SUBS

sub make_string ( Int:D $len){
    my $str;
    my @str;
    for (1..$len) {
        @str.push: (^2).pick;
    }
    @str = map { [ '(' , ')' ][$_] }, @str;
    return @str.join("");
}

sub validate (Str:D $orig) {
    my $str = $orig;
    unless $str.chars %% 2 { return "IMBALANCED - odd number of parens"};

    while $str ~~ s/\((.*?)\)/$0/ { ; }

    return ($str.chars == 0) ?? "PARENS BALANCED" !! "IMBALANCED - $str unmatched";
}

