#!/usr/bin/perl

# Challenge 203
#
# Task 2: Copy Directory
# Submitted by: Julien Fiegehenn
#
# You are given path to two folders, $source and $target.
#
# Write a script that recursively copy the directory from $source to $target
# except any files.
#
# Example
#
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

use Modern::Perl;
use File::Find;
use Path::Tiny;

sub copy_dirs {
    my($source, $target) = @_;
    my @dirs;
    find(sub {
            return unless -d $_;
            (my $path = $File::Find::name) =~ s/^$source/$target/;
            push @dirs, $path;
        }, $source);
    path($_)->mkpath for @dirs;
}

@ARGV==2 or die "usage: ch-2.pl source target\n";
copy_dirs(@ARGV);
