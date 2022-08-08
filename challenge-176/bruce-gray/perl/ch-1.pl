use v5.36;
use List::Util qw<all first>;

sub is_permuted_multiple ( $n ) {
    my ($x1, @xs) = map { join '', sort split '', $n * $_ } 1..6;

    return all { $_ == $x1 } @xs;
}

say join ' ', first { is_permuted_multiple $_ } 1..150_000;
