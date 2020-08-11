#!/usr/bin/env perl

use strict;
use warnings;
use utf8;
use feature qw{ postderef say signatures state switch };
no warnings
    qw{ experimental::postderef experimental::smartmatch experimental::signatures };

# Write a script to check the file content without explicitly
# reading the content. It should accept file name with path as
# command line argument and print "The file content is binary."
# or else "The file content is ascii." accordingly.

use Cwd 'abs_path';

for my $file (@ARGV) {
    filetest($file);
}

sub filetest($file) {
    my $path = abs_path($file);
    return unless -e $path;
    return unless -f $path;
    say $file;
    if    ( -T $path ) { say "\tThe file content is ascii" }
    elsif ( -B $path ) { say "\tThe file content is binary" }
}

# the interesting thing is that zero-length files are accepted as both.
# to keep that from happening, I used elsif and assumed ascii first
