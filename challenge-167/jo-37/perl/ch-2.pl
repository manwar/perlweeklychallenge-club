#!/usr/bin/perl -s

use v5.16;
# Circumvent conflict between "float" in PDL and Test2.
use Test2::V0 '!float', float => {-as => 'float_2'};
use PDL;
use Math::Prime::Util qw(binomial factorial);
use Math::Polynomial::Chebyshev;
use experimental 'signatures';

# Choosing g=5 and terminating the series after the 7th summand.
use constant G => 5;
use constant K => 7;

use constant PI => 4 * atan2 1, 1;

our ($tests, $examples, $verbose);

run_tests() if $tests || $examples;	# does not return

die <<EOS unless @ARGV;
usage: $0 [-examples] [-tests] [-verbose] [--] [N]

-examples
    run the examples from the challenge
 
-tests
    run some tests

-verbose
    Print intermediate matrices and vectors.

N
    Print an approximation of Γ(N).

EOS


### Input and Output

say gamma(shift);


### Implementation

# The Wiki article has a side note about an implementation by Paul
# Godfrey that generates the coefficients as a matrix product.  See
# http://www.numericana.com/answer/info/godfrey.htm.  This looks like a
# case for PDL.
# Not considering complex numbers, though this extension would be easy.

# Generate coeffients according to Godfrey.
sub gen_c {
    state $coef;
    
    # Generate only once.
    return $coef if defined $coef;

    # The matrix B is an upper right triangle matrix made of an all-one
    # row followed by the odd diagonals from Pascal's triangle with
    # alternating signs.
    my $b = ones(K)->glue(1,
        pdl(map {
            my $n = $_;
            [map {
                (-1)**($n + $_+ 1) * binomial($n + $_, 2 * $_ + 1)
                } 0 .. $n -1]
        } 0 .. K - 1)->xchg(0,1)
    );
    say "B:$b" if $verbose;


    # The matrix D is a diagonal matrix with a one followed by the
    # negative OEIS sequence A002457.
    my $d = zeroes K, K;
    $d->diagonal(0, 1) .= pdl 1,
        map -binomial(2 * $_ - 1, $_) * $_, 1 .. K - 1;
    say "D:$d" if $verbose;

    # The matrix C is a lower left triangle matrix made of the
    # coefficients of the even Chebyshev polynomials, with 1/2 as the
    # upper left value.
    my $c = pdl([.5], map
        [Math::Polynomial::Chebyshev->chebyshev(2 * $_)->coefficients],
        1 .. K - 1)->slice('0:-1:2,X');
    say "C:$c" if $verbose;

    # The vector f is a column vector as described as Fg in Godfrey's
    # equation (36). 
    my $f = pdl(map fg($_), 0 .. K - 1)->dummy(0);
    say "f:$f" if $verbose;

    say "D B C:", $d x $b x $c if $verbose;
    $coef = $d x $b x $c x $f;

    say "c:$coef" if $verbose;

    $coef;
}

# The values Fg(a) in equation (36) from Godfrey's implementation.
sub fg ($n) {
    sqrt(2 / PI) * dfac(2 * $n - 1) * exp($n + G + 0.5) /
        (2**$n * ($n + G + 0.5)**($n + 0.5));
}

# The "double factorial", see
# https://en.wikipedia.org/wiki/Double_factorial.
# Shall give 1 for n = -1.
sub dfac ($n) {
    my $df = abs($n);
    $df *= ($n -= 2) while $n > 2;
    $df;
}

# The final Gamma approximation:
sub gamma ($x) {
    # Use the mirror formula for values below 1/2.
    if ($x < 0.5) {
        return PI / (sin($x * PI) * gamma(1 - $x));
    }
    # Lanczos formula gives an approximation for Γ(x+1), thus adjusting
    # the argument.
    $x -= 1;

    # Build the row vector z as (1, 1/(x+1), 1/(x+2),...)
    my $z = sequence K;
    $z->set(0, 1);
    my $t = $z->slice('1:-1');
    $t .= 1 / ($x + $t);

    # Get Ag(z) as the scalar product of z and Ag.
    my $ag = ($z x gen_c())->sclr;

    # Calculate the gamma approximation from Ag(z).
    sqrt(2 * PI) * ($x + G + .5)**($x + .5) * exp(-($x + G + .5)) * $ag;
}


### Examples and tests

sub run_tests {
    SKIP: {
        skip "examples" unless $examples;

        is gamma(3), float_2(2), 'example 1';
        is gamma(5), float_2(24), 'example 2';
        # less exact:
        is gamma(7), float_2(720, tolerance => 1e-7), 'example 3';
    }

    SKIP: {
        skip "tests" unless $tests;

        # Special values from Wikipedia
        # https://en.wikipedia.org/wiki/Gamma_function#Particular_values
        is gamma(-1.5), float_2(4 * sqrt(PI) / 3),  '-3/2';
        is gamma(-.5),  float_2(-2 * sqrt(PI)),     '-1/2';
        is gamma(.5),   float_2(sqrt(PI)),          ' 1/2';
        is gamma(1),    float_2(1),                 ' 1';
        is gamma(1.5),  float_2(sqrt(PI) / 2),      ' 3/2';
        is gamma(2),    float_2(1),                 ' 2';
        is gamma(2.5),  float_2(3 * sqrt(PI) / 4),  ' 5/2';
        is gamma(3),    float_2(2),                 ' 3';
        is gamma(3.5),  float_2(15 * sqrt(PI) / 8), ' 7/2';

        # rounded to next integer:
        is gamma($_), float_2(factorial($_ - 1), tolerance => 0.5),
            "Γ($_)" for (4 .. 14); # Fails beyond 14.
	}

    done_testing;
    exit;
}
