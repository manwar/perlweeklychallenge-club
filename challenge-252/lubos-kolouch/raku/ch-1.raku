sub sum-of-special-squares(@ints --> Int) {
    my $n = @ints.elems;
    return [+] @ints.grep(* %% $n).map({ $_ ** 2 });
}

# Tests
use Test;
plan 2;
is sum-of-special-squares(1, 2, 3, 4), 21, 'Test Example 1';
is sum-of-special-squares(2, 7, 1, 19, 18, 3), 63, 'Test Example 2';
