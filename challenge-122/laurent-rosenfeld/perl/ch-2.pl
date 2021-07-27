use strict;
use warnings;
use feature "say";

my $target = shift // 5;
my @vals = (1, 2, 3);

sub find_dist  {
    my ($sum, @seq) = @_;
    for my $i (@vals) {
        my $new_sum = $sum + $i;
        # if $new_sum > $target, then we don't
        # need to test other values of @vals and
        # can use return instead of next
        # since these values are in ascending order
        return if $new_sum > $target;
        my @new_seq = (@seq, $i);
        if ($new_sum == $target) {
            say ""@new_seq";
            return;
        } else {
            find_dist($new_sum, @new_seq);
        }
    }
}
find_dist 0, ();
