use v5.38;

sub right($i, @intervals) {
    my $endi = ${$intervals[$i]}[1];
    my $diff = abs ($endi - ${$intervals[0]}[0]);
    my $index = -1;
    for my $j (0 .. $#intervals) {
        my $startj = ${$intervals[$j]}[0];
        if ($startj >= $endi) {
            my $d = abs($endi - $startj);
            if ($d <= $diff) {
                $diff = $d;
                $index = $j;
            }
        }
    }
    return $index;
}

sub proc(@intervals) {
    print "Input: { ";
    for (@intervals) {
        print "[";
        print join(",", @$_);
        print "], ";
    }
    say "}";
    my @outind;
    for my $i (0 .. $#intervals) {
        my $ind = right($i, @intervals);
        push @outind, $ind;
    }
    say "Output: (".join(",", @outind). ")";
}

my @intervals = ([3,4], [2,3], [1,2]);
proc(@intervals);
@intervals = ([1,4], [2,3], [3,4]);
proc(@intervals);
@intervals = ([1,2]);
proc(@intervals);
@intervals = ([1,4], [2, 2], [3, 4]);
proc(@intervals);