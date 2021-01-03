use v6;

my @tests = ((1,1), (2,2), (5, 5), (5,2), (3,3), (3,1), (2,7), (4, 4)),
            ((1,1), (2,2), (3,1), (1,3), (5,3)),
            ((1,1), (4,2), (1,3), (2,2), (1,2), (5,1), (1,4));
for @tests -> @points {
    display-points(@points);
    find-alignments(@points);
}

sub display-points (@points) {
    my @sorted = reverse sort
        { $^a[0] <=> $^b[0] || $^b[1] <=> $^a[1] },
        map { $_.reverse }, @points;
    my $current = (@sorted.max({$_[0]}))[0];
    my $max_length = (@sorted.max({$_[1]}))[1];
    my $line = "";
    my $pos = 0;
    for @sorted -> $item {
        if $item[0] < $current {
            say $line;
            $pos = 0;
            $line = "";
            $current--;
        }
        while $item[0] < $current {
            say "$current |";
            $current--;
        }
        $line = "$current |" and $pos = 0 if $line eq "";
        $line ~=  " " x ~ ($item[1] - $pos - 1) ~ "x";
        $pos = $item[1];
    }
    say $line;
    while $current-- > 0 { say "$current |" };
    say "_" x ($max_length + 3), "\n";
}

sub find-alignments (@points) {
    my %directions = (
        N  => { $^a, $^b + 1 },
        NE => { $^a + 1, $^b + 1 },
        E  => { $^a + 1, $^b },
        SE => { $^a + 1, $^b - 1 }
    );
    my %point-hash = map { "$_[0];$_[1]" => True }, @points;
    my $max-count = 0;
    for @points -> $point {
        for %directions.keys -> $dir {
            my $count = 1;
            my $p = %directions{$dir}(|$point);
            while %point-hash{"$p[0];$p[1]"} {
                $p = %directions{$dir}(|$p);
                 $count++;
            }
            $max-count = $count if $count > $max-count;
        }
    }
    say "Count: $max-count \n\n";
}
