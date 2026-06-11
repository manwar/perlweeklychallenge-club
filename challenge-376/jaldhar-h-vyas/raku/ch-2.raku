#!/usr/bin/raku

sub MAIN(
    $str
) {
    my $text = $str;

    $text = $text.subst(
        /
            :i
            <?wb> (\w+) {} :my $m = $0;
            (\s || [\s? '<' <-[>]>+ '>' \s?]+)
            ($m)
        /,
        { "\[$0]$1\[$2]" },
        :g
    );

    $text.lines.grep({ .contains(q{[}) }).join("\n").say;
}
