#!/opt/perl/bin/perl

use 5.042;

use strict;
use warnings;
no  warnings 'syntax';

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
    # Each character in the input should occur as many times in 
    # either string. This may check some letters more than once.
    #
    for my $ch (split // => $input) {
        return 0 unless eval "\$input =~ y/$ch/$ch/ == \$target =~ y/$ch/$ch/";
    }

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
