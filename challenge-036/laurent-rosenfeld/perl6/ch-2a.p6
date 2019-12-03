use v6;

constant %boxes = (
    "R" => { "w" => 1,  val => 1  },
    "B" => { "w" => 1,  val => 2  },
    "G" => { "w" => 2,  val => 2  },
    "Y" => { "w" => 12, val => 4  },
    "P" => { "w" => 4,  val => 10 },
);

sub MAIN (UInt $start-nb-boxes = 5) {
    my @boxes = keys %boxes;
    my $*max-val = 0;
    my $*max-boxes = "";
    try-one(0, 0, $start-nb-boxes, "", "A", @boxes);
    say "Max: $*max-val, Boxes:  $*max-boxes";
    say now - INIT now;
}

sub try-one ($cur-weight, $cur-val, $num-boxes, $boxes-used, $last-box-used, @boxes-left) {
    if $cur-val > $*max-val {
        $*max-val = $cur-val;
        $*max-boxes = $boxes-used;
    }
    for @boxes-left -> $box {
        next if $box lt $last-box-used;
        my $new-cur-weight = $cur-weight + %boxes{$box}{'w'};
        next if $new-cur-weight > 15 or $num-boxes <= 0;
        my @new-boxes-left = grep { $_ ne $box}, @boxes-left;
        my $new-box-used = $boxes-used ?? $boxes-used ~ "-$box" !! $box;
        try-one $new-cur-weight, $cur-val + %boxes{$box}{'val'}, $num-boxes -1, $new-box-used, $box, @new-boxes-left;
    }
}
