#!/bin/env perl6

sub is-ascii(uint8 $c --> Bool)
{ 9 <= $c <= 13 or 32 <= $c <= 126 }

sub MAIN(Str:D $file-name where *.IO.e) {
    print 'the file content is ';
    say   ([and] open($file-name, :r).read(16).list».&{ is-ascii($_) }) ??
              'ascii' !! 'binary';
}
