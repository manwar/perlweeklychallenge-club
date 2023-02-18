#!/usr/bin/env perl
# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#=============================================================================
# ch-2.pl Perl Weekly Challenge Week 203 Task 2 Copy Directory
#=============================================================================
# Copyright (c) 2023, Bob Lied
#=============================================================================
# You are given path to two folders, $source and $target.
# Write a script that recursively copy the directory from $source to $target
# except any files.
# Example: Input: $source = '/a/b/c' and $target = '/x/y'
# Source directory structure:
# 
# ├── a
# │   └── b
# │       └── c
# │           ├── 1
# │           │   └── 1.txt
# │           ├── 2
# │           │   └── 2.txt
# │           ├── 3
# │           │   └── 3.txt
# │           ├── 4
# │           └── 5
# │               └── 5.txt
# 
# Target directory structure:
# ├── x
# │   └── y
# 
# Expected Result:
# 
# ├── x
# │   └── y
# |       ├── 1
# │       ├── 2
# │       ├── 3
# │       ├── 4
# │       └── 5 
#
# From a shell prompt using find and cpio;
# ( cd $srcdir && find . -type d -print | cpio -pdumv $targetP ; )
# where $targetP is $target relative to $srcdir
#=============================================================================

use v5.36;

use File::Find;
use File::Path qw/make_path/;

use Getopt::Long;
my $Verbose = 0;

GetOptions("verbose" => \$Verbose);

my ($srcdir, $target) = @ARGV;

die "$srcdir is not a directory" unless -d $srcdir;
die "$target is not an existing directory" unless -d $target;

copyDir($srcdir, $target);

sub copyDir($srcdir, $target)
{
    # Populate the @dirtree list of directories to be created.
    # This list will be very redundant. We really only need the
    # deepest branches of the tree, because make_path will create
    # all the # intermediate levels.
    #
    # File::Find::name is the path of a directory, including $srcdir
    my @dirtree;
    find( sub() { -d && push @dirtree, $File::Find::name; }, $srcdir);

    # Substitute target for source at the beginning of each directory.
    # File::Path::make_path will create each directory, skipping over
    # levels that already exist.
    make_path( (map { s/^$srcdir/$target/; $_ } @dirtree ),
              { verbose => $Verbose } );
}
