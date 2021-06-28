#!/usr/bin/env raku

# took me a while to figure out why $x isn't equal to $r + $h - $l :(

sub MAIN($n) 
{
    traverse(0, 0, 0, $n, q{});
}

sub traverse($r, $l, $h, $n, $path) 
{
    my $x = $r + $h;
    my $y = $r + $l;

    if all($x, $y) == $n 
    {
        say $path;
    }

    else
    {
        traverse($r + 1, $l,     $h,     $n, $path ~ 'R') if $y < $n; 
        traverse($r,     $l,     $h + 1, $n, $path ~ 'H') if $h < $l; 
        traverse($r,     $l + 1, $h,     $n, $path ~ 'L') if $y < $n; 
    }
}
