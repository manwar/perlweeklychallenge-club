
sub MAIN {
    say longest-common-sequence([9,1,2,7,8,84]) // 0;
    say longest-common-sequence([2,1,3,9,7,8,4]) // 0;
}

sub longest-common-sequence(@N) {
    my %G;
    for @N.sort({ $^a <=> $^b }) -> $n {
        next if %G{$n}:exists;
        %G{$n} = %G{$n-1} // $n;
    }

    my $max = 0;
    my $group;
    for %G.keys -> $n {
        my $d = $n - %G{$n};
        if $d > $max {
            $max = $d;
            $group = $n;
        }
    }

    if $max == 0 {
        return Nil;
    } else {
        return %G{$group} ... $group;
    }
}

