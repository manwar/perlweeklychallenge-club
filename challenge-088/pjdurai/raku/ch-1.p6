use Test;


# Problem
# Write a script to return an array @M where $M[i] is the product of all elements of @N except the index $N[i]

# Solution Algorithm.

# Find the product of ALL elements first.
# Loop through the list and re-divide the overall product by that element to get "product of all but one" effect.

sub solve(@N){
    my $all-product = [*] @N;
    @N.map(-> $n {
                  $all-product / $n;
              });
}

multi sub MAIN() {
    my @N = (5, 2, 1, 4, 3);
    say "Problem  : ", @N;
    say "Solution : ", solve(@N);

    say "";

    my @N1 = (2, 1, 4, 3);
    say "Problem  : ", @N1;
    say "Solution : ", solve(@N1);
}

# Get input from command line.
# Call like:   raku ch-1.pl6  5 2 1 4 5
multi sub MAIN(*@N){
    say "Problem  : ", @N;
    say "Solution : ", solve(@N);
}
