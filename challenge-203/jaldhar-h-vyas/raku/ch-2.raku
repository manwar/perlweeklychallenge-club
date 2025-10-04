#!/usr/bin/raku
use File::Find;

sub MAIN(
    Str $source,  #= source directory path
    Str $target   #= target directory path
) {
    my $sio = $source.IO;
    my $tio = $target.IO;

    unless $tio.d {
        mkdir $target;
    }

    my @dirs = find(dir => $sio, type => 'dir');

    for @dirs -> $dir {

        my $relPath = $dir.relative($sio);
        my $newDir = $tio.add($relPath);

        mkdir $newDir;
    }
}

