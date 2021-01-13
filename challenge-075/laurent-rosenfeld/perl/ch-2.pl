use strict;
use warnings;
use feature "say";

my @a = @ARGV > 1 ? @ARGV : ( 2, 1, 4, 5, 3, 7);
draw_histo(@a);
my ($area, @rectangle) = largest_rect(@a);
say "Largest rectangle is @rectangle with an area of $area.";

sub draw_histo {
    my @in = @_;
    my $max_val = $in[0];
    for my $i (1..$#in) {
        $max_val = $in[$i] if $in[$i] > $max_val;
    }
    say "\n  ", join "  ", 0..$#in;
    say "  -" x scalar @in;
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

sub min {
    my @vals = @_;
    my $min = shift @vals;
    for my $val (@vals) {
        $min = $val if $val < $min;
    }
    return $min;
}

sub largest_rect {
    my @in = @_;
    my $largest_area = 0;
    my @best_vals = (0, 0);
    for my $i (0..$#in -1) {
        for my $j ($i + 1..$#in) {
            my $area = ($j - $i + 1) * min @in[$i..$j];
            # say "testing $i $j $area";
            if ($area > $largest_area) {
                $largest_area = $area;
                @best_vals = ($i, $j);
            }
        }
    }
    return $largest_area, @best_vals;
}
