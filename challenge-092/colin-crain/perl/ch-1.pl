#! /opt/local/bin/perl
#
#       harmonic_string_section.pl
#
#       TASK #1 › Isomorphic Strings
#             Submitted by: Mohammad S Anwar
#             You are given two strings $A and $B.
#
#             Write a script to check if the given strings are
#             Isomorphic. Print 1 if they are otherwise 0.
#
#             Example 1:
#             Input: $A = "abc"; $B = "xyz"
#             Output: 1
#             Example 2:
#             Input: $A = "abb"; $B = "xyy"
#             Output: 1
#             Example 3:
#             Input: $A = "sum"; $B = "add"
#             Output: 0

#         method:

#             From the link provided: "Two strings are isomorphic if one-to-one
#             mapping is possible for every character of the first string to
#             every character of the second string." They then provide an
#             example of isomorphism, with the two strings “ACAB” and “XCXY”.
#
#             Being acutely aware, at this point, of how the ambiguities arising
#             from written speech can confound seemingly innoculous definitions,
#             I immediately set to consider exactly what was being asked of us.
#
#             Specifically, what do we mean by a "one-to-one" mapping?
#
#             Generally, this means there exists a function that for every
#             character in string A, outputs one and only one character from
#             string B. Such a fucntion is known as an *injective* function.
#
#             But there is a second qualifier buried in the wording: "*every*
#             character of the second string". We can take this to mean that
#             there are no characters in string B that are not mapped to by some
#             character in string A. Such a function is called "surjective".
#
#             The two terms are not exclusiove: a function that is both
#             injective and surjective is known as "bijective". This is what is
#             being referred to; the relationship is also known as "one-to-one
#             onto".
#
#             Or so it seems. Although not stated, the positions of the
#             characters within the strings are important to the correspondence.
#             For example, what of the two strings "abb" and "yyx"? If "a" maps to
#             "x" and "b" maps to "y" these would seems to fit the definition. A
#             little sleuthing suggests it does not, however, and so the
#             definition should be amended to "if at each position in the first
#             string an injective mapping can be made to the character in the
#             corresponding position in the second string".
#
#             The terms "injection", "surjection" and "bijection" apply to sets,
#             and we are adressing ordered sets here. The language can still be
#             used, but requires qualification.
#
#             We're almost done, but not quite.
#
#             When we speak of a function that maps A → B, what of B → A? Is it
#             the same function? A bijective function is known as "invertable",
#             that is the one-t0-one correspondence goes both ways, but the
#             function to invert is not likely to be the same mapping, except in
#             trivial cases such f(x) = x ∀ x. The inverted function will be
#             related, but the output of the first function, when fed to the
#             second, will return the original input to the first. If we were to
#             give the original input to the scond function, the output would
#             not be immediately predictable.
#
#
#             So with definitions out of the way, how do we do this?
#
#             We need to walk the first string position by position. If the
#             character has not been seen yet, we add it to a hash that points
#             to the the corresponding letter in string B. If that letter has
#             already been seen in that string, then it has been allocated to
#             another and this love affair is over. If the letter in A has been
#             seen, it is validated be pointing to the same letter that it was
#             before. If not, again we fail.
#
#             Working across we assume success unless we fail by one of the two
#             methods. If we get to the end, the required mapping exists and the
#             two strings are isometric.
#
#             We don't need to store the values for the invert function hash —
#             we don't need to actually use the function. The logic demands that
#             to establish a new key-value pair for the forward mapping both
#             values need to be heretofore unseen, so a simple check for
#             existence of the invert hash key is all we need from it.
#


#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

sub check_iso {
    my ($str_A, $str_B) = @_;
    return 0 if length $str_A != length $str_B;

    my (%forward, %invert);
    for (0..length $str_A) {
        my $char_A = substr $str_A, $_, 1;
        my $char_B = substr $str_B, $_, 1;

        ## key already in invert
        return 0 if exists $invert{$char_B} and not exists $forward{$char_A};

        ## key in forward matches char B
        if (exists $forward{$char_A} ) {
            return 0 if $forward{$char_A} ne $char_B;
        }
        else {             ## make new key
            $forward{$char_A} = $char_B;
            $invert{$char_B}  = undef;
        }
    }
    return 1;
}


use Test::More;


is check_iso( qw ( abc xyz ) ), 1, 'ex 1';
is check_iso( qw ( abb xyy ) ), 1, 'ex 2';
is check_iso( qw ( sum add ) ), 0, 'ex 3, many to one';

is check_iso( qw ( abc bca ) ), 1, 'rearrangement';
is check_iso( qw ( abb xxy ) ), 0, 'positions matter';
is check_iso( qw ( abc abc ) ), 1, 'equality';
is check_iso( qw ( abb xyx ) ), 0, 'one to many';






done_testing();



