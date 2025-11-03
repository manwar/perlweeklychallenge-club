#!/usr/bin/raku

sub MAIN(
    *@ints
) {
    my @seen;
    my @ans;
    my $x = 0;

    for @ints.keys -> $i {
        if @ints[$i] == -1 {
            @ans.push( $x < @seen.elems ??  @seen[$x] !! -1);
            $x++;
        } else {
            @seen.unshift(@ints[$i]);
            $x = 0;
        }
    }

    say q{(}, @ans.join(q{, }), q{)};
}
