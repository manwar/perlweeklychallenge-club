use Modern::Perl;
use experimental qw<signatures>;
use List::Util   qw<first>;
use ntheory      qw<is_prime>;

# "Left-truncatable prime" is not fully defined by the task; are leading zeros valid?
# e.g. 103 -> 03 -> 3 ; all are prime, but is `03` considered a "number"?
# OEIS has separate pages for each definition:
#   http://oeis.org/A033664 2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97, 103, 107, 113, ...
#   http://oeis.org/A024785 2, 3, 5, 7, 13, 17, 23, 37, 43, 47, 53, 67, 73, 83, 97,           113, ...
# Since one definition is more easily written as a filter,
# and the other definition is best written as a generator, I have both below.

sub is_left_truncatable_prime ( $N ) {
    my @starting_positions = 0 .. length($N)-1;
    my @substrings = map   { substr $N, $_ } @starting_positions;
    my $non_prime  = first { ! is_prime $_ } @substrings;
    return ! defined $non_prime;
}
my @LTP_A033664;
{
    my $i = 0;
    while (@LTP_A033664 < 20) {
        push @LTP_A033664, $i if is_left_truncatable_prime($i);
        $i++;
    }
}

sub LTP_A024785 ( $n ) {
    state @cache;
    state @current_gen;
    @current_gen = (2, 3, 5, 7) if not @current_gen;

    while (@cache <= $n) {
        push @cache, @current_gen;
        my @next_gen = map  { my $d = $_; map { "$d$_" } @current_gen } (1..9);
        @current_gen = grep { is_prime($_) } @next_gen;
    }
    return $cache[$n];
}


say join ' ',      @LTP_A033664;
say join ' ', map { LTP_A024785($_) } 0..19;
