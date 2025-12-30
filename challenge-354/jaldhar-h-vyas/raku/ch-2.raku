#!/usr/bin/raku

sub MAIN(
    $k is copy,
    *@matrix is copy
) {
    @matrix = @matrix.map({ [ .words ] });

    my $m = @matrix.elems;
    my $n = @matrix[0].elems;

    $k %= $m * $n;

    my @flat = @matrix.map({ $_.flat }).flat;

    @flat = @flat.rotate(-$k);

    @matrix = ();
    while @flat {
        @matrix.push(@flat.splice(0, $n));
    }

    say q{(}, 
        $n < 2
          ?? q{[} ~ @matrix.join(q{, }) ~ q{]}
          !! @matrix.map({ q{[} ~ $_.join(q{, }) ~ q{]} }).join("\n"),
        q{)};
}
