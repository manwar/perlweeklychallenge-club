#!/usr/bin/perl
use v5.10;
use strict;
use warnings FATAL => 'all';
our $VERSION = '0.01';

use File::Path qw(make_path);
use File::Copy;
use File::Basename;

my $source = '/a/b/c';
my $target = '/x/y';

sub cpDir
{
    my ($src, $dst) = @_;

    opendir my $dir, $src or die "Cannot open directory: $!";
    while (my $file = readdir $dir)
    {
        next if ($file eq "." || $file eq "..");
        my $srcPath = "$src/$file";
        my $dstPath = "$dst/$file";

        if (-d $srcPath)
        {
            make_path($dstPath) unless -e $dstPath;
            cpDir($srcPath, $dstPath);
        } elsif (-f $srcPath)
        {
            # Skip files
        }
    }
    closedir $dir;
}

cpDir($source, $target);

