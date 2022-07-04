#!perl

###############################################################################
=comment

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

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Interface
---------
With no command-line flag, the hard-coded subroutines f() and g() are composed
and tested.

With a '--test' flag, subroutines $f and $g are references to anonymous sub-
routines supplied in @TEST_DATA.

Solution
--------
Subroutine compose() returns a reference to an anonymous subroutine implement-
ing the composition of functions f and g.

=cut
#==============================================================================

use strict;
use warnings;
use experimental qw( smartmatch );
use Const::Fast;
use Getopt::Long;
use Test::More;

const my $USAGE =>
"Usage:
  raku ch-2.raku -- No tests: Use explicit (named) f() and g()
  raku ch-2.raku [--test]

    --test    Run tests: Use anonymous subs as f() and g()\n";

my @TEST_DATA =
(
    [
        'Double and increment',
         sub { map { $_ + 1 } @_ },
         sub { map { $_ * 2 } @_ },
         [ 2, 3, 5, 7 ]
    ],

    [
        "Append 'q' and upper-case",
         sub { map { uc $_    } @_ },
         sub { map { $_ . 'q' } @_ },
         [ qw( a e i o u ) ]
    ],

    [
        'Halve and truncate',
         sub { map { s/ (\. .*) $ //rx } @_ },
         sub { map { $_ / 2            } @_ },
         [ 5, 6, 17, 15.3 ]
    ],
);

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 171, Task #2: First-class Function (Perl)\n\n";
}

#==============================================================================
sub compose
#==============================================================================
{
    my ($f, $g) = @_;                    # Subroutine references

    return sub                           # Reference to an anonymous subroutine
           {                  
               $f->( $g->( @_ ) )
           };
}

#------------------------------------------------------------------------------
MAIN:
#------------------------------------------------------------------------------
{
    if (parse_command_line())
    {
        for (@TEST_DATA)
        {
            my ($title, $f, $g, $input) = @$_;

            my $h    = compose( $f, $g );
            my @out1 = $f->( $g->( @$input ) );
            my @out2 = $h->( @$input );

            is_deeply( \@out1, \@out2, $title );
        }

        done_testing();
    }
    else
    {
        my @in   = (1.1, 2.34, 5, -27.6, 32);                    # Example data
        my @out1 = f( g( @in ) );
        my $h    = compose( \&f, \&g );
        my @out2 = $h->( @in );

        printf "      \@in     = %s\n", join ', ', @in;
        printf "f( g( \@in ) ) = %s\n", join ', ', @out1;
        printf "   h( \@in )   = %s\n", join ', ', @out2;

        my $same = @out1 ~~ @out2;

        printf "\n%s: The outputs are %s\n", $same ? 'SUCCESS'   : 'FAILURE',
                                             $same ? 'identical' : 'different';
    }
}

#------------------------------------------------------------------------------
sub f
#------------------------------------------------------------------------------
{
    return map { $_ * 5 } @_;
}

#------------------------------------------------------------------------------
sub g
#------------------------------------------------------------------------------
{
    return map { $_ - 3.2 } @_;
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my $test;

    GetOptions
    (
        test => \$test

    )       or error( "Invalid command line arguments\n" );

    my $args = scalar @ARGV;
       $args == 0
            or error( "Expected 0 command line arguments, found $args" );

    return $test;
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################
