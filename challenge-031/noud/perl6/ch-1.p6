# Create a function to check divide by zero error without checking if the
# denominator is zero.

# Normally you would try to divide by zero, catch the exception that's
# generated while dividing by zero.
#
# For fun, I'll try something else. Suppose we want to compute z = x / y. To
# compute z we project x and y onto a one dimensional complex sphere with
# center i / 2 and radius 1/2, and compute the division on the complex sphere.
# This project is called the stereographic projects, also see
# https://en.wikipedia.org/wiki/Stereographic_projection. The stereographic
# projects of x is
#
#   x |---> \hat(x) = x / (1 + x^2) + x^2 / (1 + x^2) * i
#
# In the stereographic projection we can divide by zero. After dividing by
# zero we end up in the north pole, which is the complex number i. Hence,
# instead of checking if the denominator is zero, we check if in the
# stereographic projection \hat(x / y) = i. Therefore, we don't check the if
# the denominator is zero explicitly. A straightforward computation gives
#
#   \hat(x / y) = xy / (x^2 + y^2) + x^2 / (x^2 + y^2) * i

sub infix:<%/>($x, $y) {
    my $z = Complex.new($x * $y / ($x**2 + $y**2), $x**2 / ($x**2 + $y**2));
    if ($z === i) {
        # If z is the north pole, the inverse stereographic projection is
        # not a number. (this is actually the perl weekly challenge)
        NaN;
    } else {
        # For fun, use the inverse stereographic projection to compute x / y.
        $z.re / (1 - $z.im);
    }
}

say 1 %/ 2;
say 3 %/ 7;
say 1 %/ 0;
say 0 %/ 0;
