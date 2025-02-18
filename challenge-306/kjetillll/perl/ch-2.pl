#https://theweeklychallenge.org/blog/perl-weekly-challenge-306/

sub last_elem {
    my($y, $x, @rest) = sort { $b <=> $a } @_;
    ! @_    ? 0
    : @_==1 ? @_
    :         last_elem( @rest, $x == $y ? () : $y - $x )
}

use Test::More tests => 2;
is last_elem(@{ $$_{input} }), $$_{output} for
{ input => [3, 8, 5, 2, 9, 2], output => 1 },
{ input => [3, 2, 5],          output => 0 },

__END__
Todo: speedup / algorithm improvement for large lists:
sort list only once and use List::BinarySearch::XS::binsearch_pos() to
find the insert positions for y-x when y != x, insert with splice()
