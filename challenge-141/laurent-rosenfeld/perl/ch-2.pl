use strict;
use warnings;
use feature "say";

my @result;

sub combine {
    my $part_comb = shift;
    my @digits = @{$_[0]};
    my $max_size = $_[1];
    push @result, $part_comb unless $part_comb eq "";
    return if length $part_comb >= $max_size;
    for my $i (0..$#digits) {
        my $new_comb = $part_comb . $digits[$i];
        combine($new_comb, [ @digits[$i+1..$#digits]], $max_size);
    }
}
sub like_numbers {
    my $n = shift;
    my @digits = split //, shift;
    combine ("", [@digits], @digits - 1);
    return grep { $_ % $n == 0 } @result;
}
for my $test ( [2, 1234], [4, 768] ) {
    @result = ();
    my @vals = like_numbers $test->[0], $test->[1];
    # say "@vals"; # -> 12 124 134 14 2 234 24 34 4
    say "@$test => ", scalar @vals;
}
