# Write a script to calculate the value of e, also known as Euler’s number and
# Napier’s constant. Please checkout wiki page for more information.


# We approximate Euler's number with a continuous fraction. First we create
# the infinite continuous array representing the continous fraction. I.e.
#
# @exp_cf = [2; 1, 2, 1, 1, 4, 1, 1, 6, 1, ..., 1, 2n, 1, ...].

my @exp_cf = 2, |(2..Inf).map({ if ($_ % 3) != 0 { 1 } else { 2/3 * $_  } });


# cf2r converts a (finite) truncation of the continuous array to a float.

sub cf2r(@cf) {
    if @cf.elems > 0 {
        @cf[0] + 1 / cf2r(@cf[1..*]);
    } else {
        1;
    }
}


# To approximate Euler's constant we take the first 50 numbers of the
# continuous fraction.

cf2r(@exp_cf[^50]).say;
