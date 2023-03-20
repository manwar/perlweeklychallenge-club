#!/bin/env raku

unit sub MAIN(
    Str:D $source where *.IO.d = 'a/b/c',
    Str:D $target where *.IO.d = 'x/y',
);

my $offset;

sub copy-dirs($source, $target) {
    for $source.IO.dir -> $file {
        next unless $file.d;

        mkdir "$target/{ $file.relative.substr($offset) }";
        copy-dirs($file, $target);
    }
}

$offset = $source.chars + 1;
copy-dirs($source, $target);
