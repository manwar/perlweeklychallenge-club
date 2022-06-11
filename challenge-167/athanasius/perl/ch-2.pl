#!perl

###############################################################################
=comment

Perl Weekly Challenge 167
=========================

TASK #2
-------
*Gamma Function*

Submitted by: Mohammad S Anwar

Implement subroutine gamma() using the [ https://en.wikipedia.org/wiki/Lanczos_
approximation |Lanczos approximation] method.

[2022-05-31]
 Ryan Thompson wrote an interesting blog explaining the subject in details.
 Highly recommended if you are looking for more information. [ https://ry.ca/
 2022/ 05/lanczos-approximation |BLOG].

Example

  print gamma(3); # 1.99
  print gamma(5); # 24
  print gamma(7); # 719.99

=cut
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=comment

Command-Line Interface
----------------------
2 arguments: Real and imaginary parts of the complex argument to the gamma
             function
1 argument:  Real part as above; the imaginary part defaults to zero
0 arguments: Run the test suite (expected values obtained from [4] and [2]).

Algorithm
---------
A port from Python to Perl of the "Simple implementation" in [3]. Note: I have
departed from the Task specification by implementing a separate factorial
calculation for positive integers. This gives more accurate results: e.g.,
gamma(3) = 2 (which is exactly correct) rather than 1.99 as in the Example.

References
----------
[1] "Gamma function", Wikipedia, https://en.wikipedia.org/wiki/Gamma_function
[2] "Gamma function Calculator", ke!san Online Calculator,
     https://keisan.casio.com/exec/system/1180573444
[3] "Lanczos approximation", Wikipedia, https://en.wikipedia.org/wiki/Lanczos_
     approximation
[4] "Particular values of the gamma function", Wikipedia,
     https://en.wikipedia.org/wiki/Particular_values_of_the_gamma_function

=cut
#==============================================================================

use strict;
use warnings;
use Const::Fast;
use Devel::Assert qw( on );
use Math::Complex qw( cplx Inf pi );
use Regexp::Common;

const my $ACCURACY   => 13;                     # Significant digits
const my $EPSILON    => 1e-12;
const my $INIT_X     => 0.99999999999980993;
const my @P_COEFS    =>
         (
               676.5203681218851,
             -1259.1392167224028,
               771.32342877765313,
              -176.61502916214059,
                12.507343278686905,
                -0.13857109526572012,
                 9.9843695780195716e-6,
                 1.5056327351493116e-7,
         );
const my $COMPLEX_RE => qr/ ($RE{num}{real}) ([+-]) ($RE{num}{real}) i /x;
const my $USAGE      =>
"Usage:
  perl $0 [<re>] [<im>]

    [<re>]    Real part
    [<im>]    Imaginary part [default: 0]\n";

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    $| = 1;
    print "\nChallenge 167, Task #2: Gamma Function (Perl)\n\n";
}

#==============================================================================
MAIN:
#==============================================================================
{
    my $z = parse_command_line();

    if (defined $z)
    {
        assert( ref $z eq 'Math::Complex' );

        printf "gamma(%s) = %s\n", $z, gamma( $z );
    }
    else
    {
        test();
    }
}

#------------------------------------------------------------------------------
sub gamma
#------------------------------------------------------------------------------
{
    my ($z) = @_;

    assert( ref $z eq 'Math::Complex' );

    my $y = cplx( Inf, 0 );         # Assume failure (use Inf to represent NaN)

    if (is_int( $z ))
    {
        # Calculate the factorial directly, for better accuracy

        $y = cplx( factorial( $z->Re - 1 ), 0 ) if $z->Re > 0;
    }
    elsif ($z->Re < 0.5)            # Reflexion: recursive call
    {
        $y = pi / (sin( pi * $z ) * gamma( 1 - $z ));
    }
    else                            # Apply the Lanczos approximation
    {
           $z -= 1;
        my $x  = $INIT_X;
        my $i  = 0;

           $x += $_ / ($z + $i++ + 1) for @P_COEFS;

        my $t  = $z + scalar( @P_COEFS ) - 0.5;
           $y  = sqrt( 2 * pi ) * $t ** ($z + 0.5) * exp( -$t ) * $x;
    }

    $y = cplx( $y->Re, 0 ) if abs( $y->Im ) <= $EPSILON;      # Drop imag. part

    return $y;
}

#------------------------------------------------------------------------------
sub is_int
#------------------------------------------------------------------------------
{
    my ($z) = @_;

    assert( ref $z eq 'Math::Complex' );

    my $real = $z->Re;

    return abs( $z->Im            ) < $EPSILON &&
           abs( $real - int $real ) < $EPSILON;
}

#------------------------------------------------------------------------------
sub factorial
#------------------------------------------------------------------------------
{
    my ($n) = @_;

    assert( $n >= 0 );

    my $fact = 1;

    for my $i (2 .. $n)
    {
        $fact *= $i;
    }

    return $fact;
}

#------------------------------------------------------------------------------
sub test
#------------------------------------------------------------------------------
{
    require Test::More;
    Test::More->import;

    while (my $line = <DATA>)
    {
        chomp $line;
        $line =~ s/ ^ \s+   //x;
        $line =~ s/   \s+ $ //x;

        my ($inp, $exp) = split / \s+ /x, $line, 2;
        my  $z_inp      = extract_cplx( $inp );
        my  $z_exp      = ($exp eq 'NaN') ? cplx( Inf ) : extract_cplx( $exp );
        my  $z_got      = round( gamma( $z_inp ) );
            $z_exp      = round(        $z_exp   );

        ok( cplx_eq( $z_got, $z_exp ), "gamma($z_inp)" )
            or printf "Expected %s,\n     Got %s\n", $z_exp, $z_got;
    }

    done_testing();
}

#------------------------------------------------------------------------------
sub extract_cplx
#------------------------------------------------------------------------------
{
    my ($str) = @_;

    my ($re, $sign, $im) = $str =~ $COMPLEX_RE;

    $im = -$im if $sign eq '-';

    return cplx( $re, $im );
}

#------------------------------------------------------------------------------
sub round
#------------------------------------------------------------------------------
{
    my ($z) = @_;

    assert( ref $z eq 'Math::Complex' );

    my $real = sprintf '%.*f', $ACCURACY - length int( $z->Re ), $z->Re;
    my $imag = sprintf '%.*f', $ACCURACY - length int( $z->Im ), $z->Im;

    $real =~ s/ \. .* (0+) $ //x;       # Trim any trailing "0" decimals
    $imag =~ s/ \. .* (0+) $ //x;
    $real =~ s/ \.         $ //x;       # Trim final decimal point (if any)
    $imag =~ s/ \.         $ //x;

    return cplx( $real, $imag );
}

#------------------------------------------------------------------------------
sub cplx_eq
#------------------------------------------------------------------------------
{
    my ($za, $zb) = @_;

    assert( ref $za eq 'Math::Complex' &&
            ref $zb eq 'Math::Complex' );

    return     ( $za->Re == Inf && $zb->Re == Inf ) ||
           (abs( $za->Re - $zb->Re ) < $EPSILON &&
            abs( $za->Im - $zb->Im ) < $EPSILON);
}

#------------------------------------------------------------------------------
sub parse_command_line
#------------------------------------------------------------------------------
{
    my   $args = scalar @ARGV;
    0 <= $args <= 2
        or error( "Expected 0, 1, or 2 command line arguments, found $args" );

    return if $args == 0;

    my $re = $ARGV[ 0 ];

    $re =~ / ^ $RE{num}{real} $ /x
        or error( qq[Real part "$re" is not a valid real number] );

    my $im = ($args == 2) ? $ARGV[ 1 ] : 0;

    $im =~ / ^ $RE{num}{real} $ /x
        or error( qq[Imaginary part "$im" is not a valid real number] );

    return cplx( $re, $im );
}

#------------------------------------------------------------------------------
sub error
#------------------------------------------------------------------------------
{
    my ($message) = @_;

    die "ERROR: $message\n$USAGE";
}

###############################################################################

__DATA__
 3+0i                                2+0i
 5+0i                               24+0i
 7+0i                              720+0i
 1+0i                                1+0i
 2+0i                                1+0i
 4+0i                                6+0i
 0+0i                                NaN
-1+0i                                NaN
 0.5+0i                              1.77245385090551+0i
 1.5+0i                              0.88622692545275+0i
 2.5+0i                              1.32934038817913+0i
 3.5+0i                              3.32335097044784+0i
-0.5+0i                             -3.54490770181103+0i
-1.5+0i                              2.36327180120735+0i
-2.5+0i                             -0.94530872048294+0i
 0+1i                               -0.15494982830181-0.49801566811835i
 1+1i                                0.49801566811835-0.15494982830181i
 1-1i                                0.49801566811835+0.15494982830181i
 0.5+0.5i                            0.81816399954174-0.76331382871398i
 0.5-0.5i                            0.81816399954174+0.76331382871398i
 5+3i                                0.01604188274165-9.43329328975598i
 5-3i                                0.01604188274165+9.43329328975598i
 1.46163214496836+0i                 0.88560319441088+0i
 0.75+0.75i                          0.59665430268224-0.37676090720240i
 0.75-2.75i                          0.03902232213674-0.01782079536849i
 3.14159265358979+3.14159265358979i -0.42793915904009-0.21380749181397i
10+0i                           362880+0i
12-11.5i                        -60802.08246207147008+249916.64966162368028i
 0.33333333333333+0i                 2.67893853470774+0i
 0.14285714285714+0i                 6.54806294024782+0i
