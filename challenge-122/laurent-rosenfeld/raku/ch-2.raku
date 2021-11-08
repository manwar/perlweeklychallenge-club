use v6;

my $target = @*ARGS[0] // 5;
my @vals = 1, 2, 3;

sub find-dist ($sum, @seq) {
    for @vals -> $i {
        my $new-sum = $sum + $i;
        # if $new-sum > $target, then we don't
        # need to test other values of @vals and
        # can use return directly instead of next
        # since these values are in ascending order
        return if $new-sum > $target;
        my @new-seq = |@seq, $i;
        if $new-sum == $target {
            say ~@new-seq;
            return;
        } else {
            find-dist($new-sum, @new-seq);
        }
    }
}
find-dist 0, ();
