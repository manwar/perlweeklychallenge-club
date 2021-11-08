#!/usr/bin/raku

sub circle(Int $radius, $c) {
    my $widthScale = 6;
    my $width = 3 + (0.5 + $widthScale * $radius).Int;
    my $radius2 = $radius ** 2;

    for -$radius .. ($radius) -> $y {
        my $x = (0.5 + ($widthScale * ($radius2 - $y ** 2)) ** 0.5).Int;
        say ' ' x (($width div 2) - $x), $c, ' ' x (2 * $x - 4), $c;
    }
}

sub cross(Int $height, $c) {
    my $widthScale = 6;
    my $width = 3 + (0.5 + $widthScale * $height).Int;
    my $height2 = $height ** 2;

    for 0 .. $height -> $y {
        if $y == ($height * 2 / 3).Int {
            my $x = (0.5 + ($widthScale * ($height2 - $y ** 2)) ** 0.5).Int;
            say ' ' x $width div 3 - 2, $c x (3 * $x / 2).Int;
        } else {
            say ' ' x ($width div 2), $c;
        }
    }
}

sub MAIN() {

    circle(5, '*');
    cross(5, '*');
}

