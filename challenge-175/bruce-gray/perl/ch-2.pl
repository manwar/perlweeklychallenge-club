use v5.36;
use ntheory    qw<euler_phi  vecsum>;
use List::Lazy qw<lazy_range lazy_list>; # Just for fun, to mimic Raku

sub totients_sum ( $n ) {
    my $totients = lazy_list { $_ > 1 ? $_ = euler_phi $_ : () } $n;

    return vecsum $totients->all;
}

sub is_perfect_totient () { $_ == totients_sum($_) }

my $perfect_totients = lazy_range(1, undef)->grep(\&is_perfect_totient);

say join ' ', $perfect_totients->next(20);
