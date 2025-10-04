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

        # Get relative path from source
        my $rel-path = $dir.relative($sio);
        # Create the directory in target
        my $new-dir = $tio.add($rel-path);

        mkdir $new-dir;
    }
}

