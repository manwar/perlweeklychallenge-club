#!/usr/bin/raku

sub MAIN(
    $s1,
    $s2,
    $s3
) {
    my $ops = 0;
    my @strs = ($s1, $s2, $s3);

    loop {
        if @strs.map({ $_.chars }).any == 0 {
            say -1;
            last;
        }
        
        if [eq] @strs {
            say $ops;
            last;
        }

        my $maxlen = @strs.map({ $_.chars }).max;
        for @strs.keys -> $i {
            if @strs[$i].chars == $maxlen {
                @strs[$i] = @strs[$i].substr(0, *-1);
                $ops++;
            }
        }
    }
}