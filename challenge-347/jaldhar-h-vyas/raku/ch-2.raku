#!/usr/bin/raku

sub MAIN(
    $phone
) {
    my $formatted = S:g/' ' || \-// given $phone;
    my @groups = $formatted.comb(3);

    if @groups[*-1].chars == 1 {
        @groups[*-2] = @groups[*-2].subst(/(.)$/, q{});
        @groups[*-1] = "$0@groups[*-1]";
    }

    @groups.join(q{-}).say;
}