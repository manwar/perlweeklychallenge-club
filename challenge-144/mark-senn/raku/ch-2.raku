# Number of Ulam sequence numbers to generate.
my $n = 10;

# Read $u and $v --- the first and second Ulam sequence numbers.
my $u = $*IN.get;
my $v = $*IN.get;
say "Input: \$u = $u, \$v = $v";

# Initialize the Ulam sequence.
my @ulam = ($u, $v);

while @ulam.elems < $n {

    # Compute @ulam[0]+@ulam[0], @ulam[1]+@ulam[2], ...
    # Save all sums that are greater than the last current Ulam sequence element.
    # And sort the list numerically.
    my @sum = (@ulam X+ @ulam).grep(* > @ulam[*-1]).sort(+*);

    # For each @sum, tally the number of times it occurs.
    my %tally = ();
    %tally{$_}++ for @sum;

    # Go through the %tally elements in numerically sorted order.
    for %tally.keys.sort(+*) {
        # If the tally value is two or three,
        # then add this tally value to the Ulam sequence,
        # and calculate the next Ulam sequence value.
        #
        # The tally value occurs twice or three times because,
        # for example, when computing the forth (1,2)-Ulam sequence
        # element, 2 + 4 = 3 + 3 = 4 + 2.
        (%tally{$_} == 2|3) and @ulam.push($_), last
    }
}

say "Output: {@ulam.join(', ')}";
