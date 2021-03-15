#!/usr/bin/env raku

sub what's-playing ( $start-time, $current-time = now, $file = 'playlist.csv'  ) {
    my (@time, @name) := [Z] $file.IO.lines.map: {.split: ',', 2};
    my @time-to = [\+] |@time.map: * / 1000;
    my $time-in-playlist = ($current-time - $start-time) % @time-to.tail;

    @time-to.first: * >  $time-in-playlist,:k
    andthen @name[$_] => ($time-in-playlist - (0,|@time-to)[$_]).polymod(60, 60).reverse.fmt('%02d',':');
}

multi MAIN (Bool :$test!) {
    use Test;
    is   what's-playing( 1606134123, 1614591276, ).value, '00:10:24';
    like what's-playing( 1606134123, 1614591276, 'playlist.csv').key, /:s Episode 1/;
    is   what's-playing( 1606134123, 1694591276, ).value, '00:08:46';
    like what's-playing( 1606134123, 1694591276, ).key, /:s Episode 6/;
    done-testing;
}

multi MAIN ( $start-time, $current-time = now, $file = 'playlist.csv' ) {
    say what's-playing $start-time,  $current-time, $file
}
