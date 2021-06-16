#!/usr/bin/env raku

# took me a while to figure out why $x isn't equal to $r + $h - $l :(

sub MAIN($n) 
{
    travel(0, 0, 0, $n, q{});
}

sub travel($r, $l, $h, $n, $path) 
{
    my $x = $r + $h;
    my $y = $r + $l;

    if all($x, $y) == $n 
    {
        say $path;
    }

    else
    {
        travel($r + 1, $l,     $h,     $n, $path ~ 'R') if $y < $n; 
        travel($r,     $l,     $h + 1, $n, $path ~ 'H') if $h < $l; 
        travel($r,     $l + 1, $h,     $n, $path ~ 'L') if $y < $n; 
    }
}
