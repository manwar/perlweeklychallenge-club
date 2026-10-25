#!/usr/bin/raku

sub MAIN(
    Str $order,
    Str $friends
) {
    my @order = $order.words;
    my @friends = $friends.words;

    say q{(},
        @friends.sort({ @order.first($^a, :k) <=> @order.first($^b, :k) }).join(q{, }),
        q{)};
}
