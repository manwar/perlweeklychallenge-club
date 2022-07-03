use v6d;

###############################################################################
=begin comment

Perl Weekly Challenge 171
=========================

TASK #2
-------
*First-class Function*

Submitted by: Mohammad S Anwar

Create sub compose($f, $g) which takes in two parameters $f and $g as sub-
routine refs and returns subroutine ref i.e. compose($f, $g)->($x) = $f->
($g->($x))


e.g.

  $f = (one or more parameters function)
  $g = (one or more parameters function)

  $h = compose($f, $g)
  $f->($g->($x,$y, ..)) == $h->($x, $y, ..) for any $x, $y, ...

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Interface
---------
With no command-line flag, the hard-coded subroutines f() and g() are composed
and tested.

With a '--test' flag, subroutines &f and &g are set to (references to) anony-
mous subroutines supplied in @TEST-DATA.

Solution
--------
Subroutine compose() uses infix:<∘>, Raku's built-in function composition
operator ( https://docs.raku.org/routine/o,%20infix%20%E2%88%98 ).

=end comment
#==============================================================================

use Test;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 171, Task #2: First-class Function (Raku)\n".put;
}

#==============================================================================
sub compose( &f, &g --> Callable:D )
#==============================================================================
{
    &f ∘ &g;
}

#------------------------------------------------------------------------------
multi sub MAIN
(
    #= No tests: Use explicit (named) f() and g()
)
#------------------------------------------------------------------------------
{
    my @in   = 1.1, 2.34, 5, -27.6, 32;                          # Example data
    my @out1 = f( g( @in ) );
    my &h    = compose( &f, &g );
    my @out2 = &h( @in );

    "      \@in     = %s\n".printf: @in\ .join: ', ';
    "f( g( \@in ) ) = %s\n".printf: @out1.join: ', ';
    "   h( \@in )   = %s\n".printf: @out2.join: ', ';

    my Bool $match  = @out1 ~~ @out2;

    "\n%s: The outputs are %s\n".printf: $match ?? 'SUCCESS'   !! 'FAILURE',
                                         $match ?? 'identical' !! 'different';
}

#------------------------------------------------------------------------------
multi sub MAIN
(
    Bool:D :$test               #= Run tests: Use anonymous subs as f() and g()
)
#------------------------------------------------------------------------------
{
    my constant @TEST-DATA =
        [
            'Double and increment',
             sub { @_.map: { $_ + 1 } },
             sub { @_.map: { $_ * 2 } },
             [ 2, 3, 5, 7 ]
        ],
        [
            "Append 'q' and upper-case",
             sub { @_.map: { .uc      } },
             sub { @_.map: { $_ ~ 'q' } },
             [ < a e i o u > ]
        ],
        [
            'Halve and truncate',
             sub { @_.map: { S/ (\. .*) $ // } },
             sub { @_.map: { $_ / 2          } },
             [ 5, 6, 17, 15.3 ]
        ];

    for @TEST-DATA
    {
        my (Str $title, &f, &g, $input) = @$_;

        my &h    = compose( &f, &g );
        my @out1 = &f( &g( @$input ) );
        my @out2 = &h( @$input );

        is-deeply @out1, @out2, $title;
    }

    done-testing;
}

#------------------------------------------------------------------------------
sub f                # Signature defaults to *@_ because @_ appears in sub body
#------------------------------------------------------------------------------
{
    return @_.map: { $_ * 5 };
}

#------------------------------------------------------------------------------
sub g                # Signature defaults to *@_ because @_ appears in sub body
#------------------------------------------------------------------------------
{
    return @_.map: { $_ - 3.2 };
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s:g/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

###############################################################################
