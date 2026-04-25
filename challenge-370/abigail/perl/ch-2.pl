#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

#
# Two words are anagrams if we sort the letters, rejoin them,
# and end up with equal strings
#
sub are_anagrams ($str1, $str2) {
    my $s_str1 = join "" => sort split // => $str1;
    my $s_str2 = join "" => sort split // => $str2;
    return $s_str1 eq $s_str2
}

sub can_scramble ($input, $target) {
    #
    # We're done if the input matches the target
    #
    return 1 if $input eq $target;

    #
    # There is no solution if the strings aren't of the same size
    #
    return 0 if length ($input) != length ($target);

    #
    # There is no solution if the strings don't contain the 
    # same sets of letters (aka, being anagrams)
    #
    return 0 unless are_anagrams ($input, $target);

    #
    # Try each split length
    #
    for (my ($l, $m) = (1, length ($input) - 1); $m >= 1; $l ++, $m --) {
        #
        # We can scramble if both $first and $second scramble the
        # appropriate parts of the target -- or if we switch the
        # parts, and can then match.
        #
        return 1 if
           can_scramble (substr ($input,   0, $l), substr ($target,  0, $l)) &&
           can_scramble (substr ($input,  $l, $m), substr ($target, $l, $m)) ||
           can_scramble (substr ($input,  $l, $m), substr ($target,  0, $m)) &&
           can_scramble (substr ($input,   0, $l), substr ($target, $m, $l));
    }

    return 0;
}

while (<>) {
    my ($str1, $str2) = split;
    say can_scramble ($str1, $str2) ? "true" : "false";
}

__END__
