#!/usr/bin/raku

sub MAIN(
    *@bits
) {
    my $arg = @bits.join(q{});
    $arg ~~ s:g/10/b/;
    $arg ~~ s:g/11/c/;
    $arg ~~ s:g/0/a/;
    say $arg ~~ /a$/ ?? 1 !! 0;
}