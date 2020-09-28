use strict;
use warnings;
use feature "say";

my @a = @ARGV > 1 ? @ARGV : ( 2, 1, 4, 5, 3, 7);
draw_histo(@a);
say "Rain capacity is: ", capacity(@a);

sub max {
    my @vals = @_;
    my $max = shift @vals;
    for my $val (@vals) {
        $max = $val if $val > $max;
    }
    return $max;
}

sub min2 {
    $_[0] < $_[1] ? $_[0] : $_[1];
}

sub draw_histo {
    my @in = @_;
    my $max_val = max @in;
    say "";
    for my $ordinate (reverse 1..$max_val) {
        print $ordinate;
        for my $i (0..$#in) {
            print $in[$i] >= $ordinate ? " # " : "   ";
        }
        say "";
    }
    say "  =" x scalar @in;
    say "  ", join "  ", @in;
    say "";
}

sub capacity {
    my @in = @_;
    my $left_max = $in[0];
    my $total = 0;
    for my $i (1..$#in-1) {
        $left_max = $in[$i] and next if $in[$i] > $left_max;
        my $right_max = max @in[$i+1..$#in];
        my $col = min2($left_max, $right_max) - $in[$i];
        next if $col < 0;
        $total += $col;
    }
    return $total
}
