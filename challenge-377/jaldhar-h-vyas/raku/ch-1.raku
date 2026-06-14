#!/usr/bin/raku

sub MAIN(
    $str
) {
    my $strsubs = SetHash.new;
    my $revsubs = SetHash.new;

    for 0 ..^ $str.chars - 1 -> $i {
        my $sub = $str.substr($i, 2);
        $strsubs.set($sub);
        $revsubs.set($sub.flip);
    }

    ($strsubs ∩ $revsubs).elems.so.say;
}
