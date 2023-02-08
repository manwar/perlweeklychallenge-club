#! /usr/bin/raku

sub getdirs($src) {
    my @a;
    for dir($src) -> $e {
        if ($e.d) {
            @a.push($e);
            @a.append(getdirs($e))
        }
    }
    return @a;
}

sub copydir($src, $dst) {
    my $l = 1 + $src.chars;
    for map {$_.substr($l)}, getdirs($src) -> $o {
        mkdir "$dst/$o";
    }
}

copydir('a/b/c', 'x/y');
