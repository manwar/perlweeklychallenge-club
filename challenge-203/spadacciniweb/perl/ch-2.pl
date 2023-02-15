#!/usr/bin/env perl

# Task 2: Copy Directory
# Submitted by: Julien Fiegehenn
# 
# You are given path to two folders, $source and $target.
# Write a script that recursively copy the directory from $source to $target except any files.
# 
# Example
# Input: $source = '/a/b/c' and $target = '/x/y'
# 
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
# 
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

use strict;
use warnings;
use File::Find;
no warnings 'experimental::smartmatch';

print "path source: ";
my $source = <>;
chop $source;
unless (-d $source) {
    printf "%s directory does not exist.", $source || '-';
    exit 1;
}

print "path target: ";
my $target = <>;
chop $target;
unless (-d $target) {
    printf "%s directory does not exist.", $target || '-';
    exit 1;
}

my @dirs;
find({ wanted => \&finddirs }, $source);

foreach my $dir (@dirs) {
    mkdir $target . $dir or die($!);
}

exit 0;

sub add_dir {
    my $dir = shift;
    if (-d $dir) {
        $dir = substr $dir, length($source);
        push @dirs, $dir
            if $dir and
               not($dir ~~ @dirs);
    }
}

sub finddirs {
    add_dir($File::Find::name);
}
