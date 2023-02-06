#!/usr/bin/env raku

my $source      = '/usr/home/andemark/tmp/a/b/c'.IO;
my $destination = '/usr/home/andemark/tmp/x/y'.IO;

mkdir $destination.add: .basename for $source.dir;
