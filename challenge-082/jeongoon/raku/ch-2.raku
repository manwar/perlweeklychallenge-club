#!/usr/bin/env raku
# -*- Mode: Raku; indent-tabs-mode: nil; coding: utf-8 -*-
# vim: set et ts=4 sw=4:

use v6.d;

=begin testing

tested with: raku jeongooon/raku/ch-2.raku XXY XXZ XXXXZY

result look like

1 as we found 6 possible senario(s)
e.g) 'XXXXZY' can be decomposed like below.

["X", "X", "X", "X", "Z", "Y"] -(uninterleave)-> XXY, XXZ
["X", "X", "X", "XZ", "Y"] -(uninterleave)-> XXZ, XXY
["X", "XX", "X", "Z", "Y"] -(uninterleave)-> XXZ, XXY
["X", "XX", "XZ", "Y"] -(uninterleave)-> XXY, XXZ
["XX", "XX", "Z", "Y"] -(uninterleave)-> XXY, XXZ
["XX", "XXZ", "Y"] -(uninterleave)-> XXZ, XXY

=end testing

# blog: https://dev.to/jeongoon/weekly-challenge-081-task-2-elm-raku-p92

# real entry point
sub all-possible-partitions( \A, \B, \C ) {
    my $sum = C.chars;
    sps_( 1, $sum, Empty, Empty,
          sub (List $parts) {
                if ( $parts.elems <= 1 ) {
                    return True; # only needed to keep going through
                }
                # check interleaved **partially**
                my ( $splited, \o, \e ) = uninterleave( C, $parts );

                ( (A,B)|(B,A) ).map( # |: any
                    {
                        my \om = ($^a, o)>>.chars.min;
                        my \em = ($^b, e)>>.chars.min;

                        [eq] ($^a,o)>>.substr(^om)
                        and
                        [eq] ($^b,e)>>.substr(^em)
                    })[0].so
            } ).
    grep( *.elems > 0 ).
    map(
        {
            with uninterleave( C, $_.List ) { # .List needed
                (( A eq .[1] and B eq .[2])
                 or
                 ( B eq .[1] and A eq .[2])).so
                or next;

                $_; # return result of uninterleave() when True
            }
        });
}


# make permutations with repeatition and filtering
# to divide the given $sum into smaller natural numbers
# note: still need to sieve after work to get right result.
sub sps_ ( Int $n, Int $sum, $parts, $siblings, &is-valid ) returns List {
    ().return if $sum == 0;

    my $parts-new = (|$parts, $n);

    if is-valid( $parts-new ) {
        if $n == $sum { # last case in the siblings (or depth)
                        # (no more *next* cases in other word)
                        # because we are checking from 1 to maximum
            (|$siblings, ($n,)).return; # comma required
        }
        else {
            # may have lower cases (if valid) and next cases
            my $lower-cases = samewith( 1, ($sum-$n), $parts-new,
                                        Empty, &is-valid );

            my $curr-cases = (($n,) X $lower-cases.List).map(*.flat);
            # note: .List is needed because it's itemized
            # and which makes slip and flattening very hard :-$

            # check next cases with current cases as a sibling
            samewith($n.succ, $sum, $parts,
                     (|$siblings, |$curr-cases), &is-valid);
        }
    }
    else {
        $siblings.return;
    }
}

sub uninterleave( Str $str, List $split-rule ) {
    # return as ( <splited $str>, <odd joined> <even joined> ) )
    $split-rule.elems > 1 or Empty.return;

    with ( ([\+] (0, |$split-rule)). # each block size -> each index in string
            rotor( 2 => -1 ).         # two pairs of indices surrounding a block
            map({$str.substr(.[0] ..^ .[1])}) ).cache {
        ## return values ...

        .self,
        # `-> 1. string partitions itself
        (.pairs.
         classify( {.key %% 2 ?? "e" !! "o" },
                   :as{.value} )).<o e>>>.join("").Slip;

        # `-> 2. string joined out of odd indexed blocks
        #     3. string joined out of even indexed blocks

    }
}

sub MAIN ( *@str where { @str.elems == 3 and @str.all.chars > 0 } ) {
    my (\A, \B, \C) = @str;

    if A.chars + B.chars != C.chars {
        print "0";
        $*ERR.print( " as length A + B != C" );
        say "";
        exit 0;
    }

    my @found-cases = all-possible-partitions( A, B, C );
    if @found-cases.elems == 0 {
        print "0"; $*ERR.print( " as no interleaved case found." );
        say "";
    }
    else {
        print "1";
        $*ERR.say( " as we found {@found-cases.elems} possible senario(s)\n" ~
        "e.g) '{C}' can be decomposed like below" );
        say "";

        for @found-cases -> ($splited, $a, $b) {
            $*ERR.say( "{$splited.Array.raku} -(uninterleave)-> $a, $b" );
        }
    }
}
