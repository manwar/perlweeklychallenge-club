# Write a script or one-liner to remove leading zeros from positive
# numbers.

use v6;
use Test;

sub remove_leading_zeros($num) {
    $num.subst(/^(
                  0*                # match all leading 0s followed by
                  <?before 0\.>     # 0. (not included in match)
                  ||
                  0*                # or just all leading 0s
                  )
               /, 
               '');
}

# we let multi dispatch pick positive numbers
multi sub MAIN(Numeric $num where $num > 0) {
    say remove_leading_zeros($num);
}

# if not a positive number, just echo input
multi sub MAIN($other) {
    say $other;
}

# test if no input
multi sub MAIN() {
    # we only test the legal number input, because other input is
    # sorted out by multi methods
    is(remove_leading_zeros("0001"),      "1");
    is(remove_leading_zeros("0.001"),     "0.001");
    is(remove_leading_zeros(".001"),      ".001");
    is(remove_leading_zeros("000.001"),   "0.001");
    done-testing();
}
