#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # 🦋 ∅ ≡ ∩ ≢ ∈ «␤»
use v6.d;
use lib $?FILE.IO.parent(2).add("lib");
use Test;

=begin comment
190-1: Capital Detection        Submitted by: Mohammad S Anwar

Given a string with alphabetic characters only: A..Z and a..z.

Determine if the usage of capitals is legal by complying with one
of the following rules, and return 0 or the rule number satisfied:

1) Only first letter is capital and all others are small.
2) Every letter is small.
3) Every letter is capital.

Example 1
Input: $s = 'Perl'
Output: 1
Example 2
Input: $s = 'TPF'
Output: 1
Example 3
Input: $s = 'PyThon'
Output: 0
Example 4
Input: $s = 'raku'
Output: 1
=end comment

=begin comment
Often when doing a weekly challenge, I choose some scenario of usage to
satisfy rather than just fulfilling the bare challenge reqs.

This time, I have just imagined this requirement is of great import, has
an undisclosed purpose, and should play well with NIH code.  So there is
some effort to resolve the upper-case vs. title-case ambiguity, and to
keep the configuration from polluting other namespaces.
=end comment


# %*ENV<ITUC-prefer> = Int;   # Set to 3 for UPPER, 1 for TITLE,


# NOTE:  ?! Keeping enum scope narrow for Int namespace collision avoidance.
enum Rule < FAIL-CASE TITLE-CASE LOWER-CASE UPPER-CASE>;

sub is-title-or-a-uniform-case(
            Any:D(Str) $s,
            Int $ITUC-prefer = %*ENV<ITUC-prefer>;
            --> Int
) {
    unless $ITUC-prefer == (UPPER-CASE, TITLE-CASE).any {
        warn
  "WARNING:  Default for title- vs upper-case preference has not been set\n"
~ "    locally.  Using value for Timbuktu, Mali.  It is recommended to\n"
~ "    set \%*ENV<ITUC-prefer> or parameter \$ITUC-prefer." ;
       $ITUC-prefer = UPPER-CASE;
    }
    given $s {
        when / ^ <:Lu>        $ / { return $ITUC-prefer }
        when / ^ <:Ll>+       $ / { return LOWER-CASE }
        when / ^ <:Lu>+       $ / { return UPPER-CASE }
        when / ^ <:Lu> <:Ll>+ $ / { return TITLE-CASE }
        when / ^ <:L>+        $ / { return  FAIL-CASE }
        default {
            die "I could handle this if my programmer had been smarter: '$s'";
        }
    }
}

multi MAIN ( ) {  MAIN('T' ) }

multi MAIN ( $t where * = < T t>.any ) {

    my @Test =
        { s => 'U'     , upper => UPPER-CASE, title => TITLE-CASE },
        { s => 'Raku'  , upper => TITLE-CASE, title => TITLE-CASE },
        { s => 'RAKU'  , upper => UPPER-CASE, title => UPPER-CASE },
        { s => 'raku'  , upper => LOWER-CASE, title => LOWER-CASE },
        { s => 'Ul'    , upper => TITLE-CASE, title => TITLE-CASE },
        { s => 'UU'    , upper => UPPER-CASE, title => UPPER-CASE },
        { s => 'l'     , upper => LOWER-CASE, title => LOWER-CASE },
        { s => 'll'    , upper => LOWER-CASE, title => LOWER-CASE },
        { s => 'Perl'  , upper => TITLE-CASE, title => TITLE-CASE },
        { s => 'lUlU'  , upper =>  FAIL-CASE, title =>  FAIL-CASE },
        { s =>  'TPF'  , upper => UPPER-CASE, title => UPPER-CASE },
        { s => 'PyThon', upper =>  FAIL-CASE, title =>  FAIL-CASE },
        { s => 'pY'    , upper =>  FAIL-CASE, title =>  FAIL-CASE },
=begin comment
=end comment
    ;

    my @Dead =
        { s => 'Ra ku', why => 'non-Letters'},
        { s => 'Ra0ku', why => 'non-Letters'},
        { s => ''     , why => 'empty Str'},
        { s => (Str)  , why => 'undefined' },
    ;

    plan @Dead + +@Test × 2;
    for @Dead -> %t {
        %*ENV<TUC-prefer> = UPPER-CASE;
        dies-ok { is-title-or-a-uniform-case( %t<s>) },
                "dies: %t<why>, "
                ~  ( %t<s>.defined ??  "'%t<s>'" !! %t<s>.raku);
    }
    for @Test -> %t {
        is is-title-or-a-uniform-case( %t<s>, TITLE-CASE), %t<title>,
                "%t<s> --> %t<title>";
        is is-title-or-a-uniform-case( %t<s>, UPPER-CASE), %t<upper>,
                "%t<s> --> %t<upper>";
    }
    done-testing;
}

