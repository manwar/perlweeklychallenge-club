use v6d;

###############################################################################
=begin comment

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

=end comment
###############################################################################

#--------------------------------------#
# Copyright © 2022 PerlMonk Athanasius #
#--------------------------------------#

#==============================================================================
=begin comment

Command-Line Interface
----------------------
2 arguments: Real and imaginary parts of the complex argument to the gamma
             function
1 argument:  Real part as above; the imaginary part defaults to zero
0 arguments: Run the test suite (expected values obtained from [4] and [2]).

Note: If the first argument (the real part) is negative, its minus sign will be
interpreted as a command-line flag. To prevent this, it is necessary to precede
the first argument with a double dash:

    raku ch-2.raku -- -0.5

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

=end comment
#==============================================================================

my UInt constant $ACCURACY =  13;                          # Significant digits
my Real constant $EPSILON  =   1e-12;
my Real constant $INIT-X   =   0.99999999999980993;
my      constant @P-COEFS  = 676.5203681218851,
                           -1259.1392167224028,
                             771.32342877765313,
                            -176.61502916214059,
                              12.507343278686905,
                              -0.13857109526572012,
                               9.9843695780195716e-6,
                               1.5056327351493116e-7;

#------------------------------------------------------------------------------
BEGIN
#------------------------------------------------------------------------------
{
    "\nChallenge 167, Task #2: Gamma Function (Raku)\n".put;
}

#==============================================================================
sub MAIN
(
    Real $re?,          #= Real part
    Real $im = 0,       #= Imaginary part
)
#==============================================================================
{
    if $re.defined
    {
        my Complex $z = Complex.new: $re, $im;

        "gamma($z) = { gamma( $z ) }".put;
    }
    else
    {
        test();
    }
}

#------------------------------------------------------------------------------
sub gamma( Complex:D $z is rw --> Complex:D )
#------------------------------------------------------------------------------
{
    my Complex $y = Complex.new: NaN, 0;      # Assume failure

    if is-integer( $z )
    {
        if $z.re > 0
        {
            # Calculate the factorial directly, for better accuracy

            $y = Complex.new: factorial( $z.re.Int - 1 ), 0;
        }
    }
    elsif $z.re < 0.5                         # Reflexion: recursive call
    {
        my Complex $w = 1 - $z;

        $y = π / ((π * $z).sin * gamma( $w ));
    }
    else                                      # Apply the Lanczos approximation
    {
           $z -= 1;
        my $x  = $INIT-X;
        my $i  = 0;

           $x += $_ / ($z + $i++ + 1) for @P-COEFS;

        my $t  = $z + +@P-COEFS - 0.5;
           $y  = (2 * π).sqrt * $t ** ($z + 0.5) * (-$t).exp * $x;
    }

    $y = Complex.new: $y.re, 0 if $y.im.abs <= $EPSILON;      # Drop imag. part

    return $y;
}

#------------------------------------------------------------------------------
sub is-integer( Complex:D $z --> Bool:D )
#------------------------------------------------------------------------------
{
    my Real $real = $z.re;

    return                 ($z.im.abs < $EPSILON) &&
           (($real - $real.floor).abs < $EPSILON);
}

#------------------------------------------------------------------------------
sub factorial( UInt:D $n --> UInt:D )
#------------------------------------------------------------------------------
{
    my $fact = 1;

    for 2 .. $n -> UInt $i
    {
        $fact *= $i;
    }

    return $fact;
}

#------------------------------------------------------------------------------
sub test()
#------------------------------------------------------------------------------
{
    use Test;

    for data().lines -> Str $line is copy
    {
        $line ~~ s/ ^ \s+   //;
        $line ~~ s/   \s+ $ //;

        my Str ($inp, $exp) = $line.split: / \s+ /, 2, :skip-empty;
        my Complex $z-inp   = extract-cplx( $inp );
        my Complex $z-exp   = extract-cplx( $exp );

        my $z-got = round( gamma( $z-inp ) );
           $z-exp = round(        $z-exp   );

        ok cplx-eq( $z-got, $z-exp ), "gamma($z-inp)";
    }

    done-testing();
}

#------------------------------------------------------------------------------
sub extract-cplx( Str:D $str --> Complex:D )
#------------------------------------------------------------------------------
{
    my Str ($re, $sign, $im) =
        $str.split( / <?after \S> <[+-]> /, 3, :skip-empty, :v ).map: { .Str };

    $im ~~ s/ i $ //;
    $im = '-' ~ $im if $sign eq '-';

    return Complex.new: $re.Real, $im.Real;
}

#------------------------------------------------------------------------------
sub round( Complex:D $z --> Complex:D )
#------------------------------------------------------------------------------
{
    return $z if $z.isNaN;

    my Str $real = '%.*f'.sprintf: $ACCURACY - $z.re.Int.chars, $z.re;
    my Str $imag = '%.*f'.sprintf: $ACCURACY - $z.im.Int.chars, $z.im;

    $real ~~ s/ \. .* (0+) $ //;        # Trim any trailing "0" decimals
    $imag ~~ s/ \. .* (0+) $ //;
    $real ~~ s/ \.         $ //;        # Trim final decimal point (if any)
    $imag ~~ s/ \.         $ //;

    return Complex.new: $real.Real, $imag.Real;
}

#------------------------------------------------------------------------------
sub cplx-eq( Complex:D $za, Complex:D $zb --> Bool:D )
#------------------------------------------------------------------------------
{
    return  ($za.isNaN && $zb.isNaN) ||
           (($za.re - $zb.re).abs < $EPSILON &&
            ($za.im - $zb.im).abs < $EPSILON);
}

#------------------------------------------------------------------------------
sub error( Str:D $message )
#------------------------------------------------------------------------------
{
    "ERROR: $message".put;

    USAGE();

    exit 0;
}

#------------------------------------------------------------------------------
sub USAGE()
#------------------------------------------------------------------------------
{
    my Str $usage = $*USAGE;

    $usage ~~ s/ ($*PROGRAM-NAME) /raku $0/;

    $usage.put;
}

#------------------------------------------------------------------------------
sub data()
#------------------------------------------------------------------------------
{
    return q:to/END/;
 3+0i                                2+0i
 5+0i                               24+0i
 7+0i                              720+0i
 1+0i                                1+0i
 2+0i                                1+0i
 4+0i                                6+0i
 0+0i                                NaN+0i
-1+0i                                NaN+0i
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
END
}

###############################################################################
