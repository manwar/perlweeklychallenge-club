#!/usr/bin/perl
# https://theweeklychallenge.org/blog/perl-weekly-challenge-203/#TASK2
# Task 2: Copy Directory
#
# You are given path to two folders, $source and $target.
#
# Write a script that recursively copy the directory from $source to $target except any files.
#
## Example
##
## Input: $source = '/a/b/c' and $target = '/x/y'
##
## Source directory structure:
##
## ├── a
## │   └── b
## │       └── c
## │           ├── 1
## │           │   └── 1.txt
## │           ├── 2
## │           │   └── 2.txt
## │           ├── 3
## │           │   └── 3.txt
## │           ├── 4
## │           └── 5
## │               └── 5.txt
##
## Target directory structure:
##
## ├── x
## │   └── y
##
## Expected Result:
##
## ├── x
## │   └── y
## |       ├── 1
## │       ├── 2
## │       ├── 3
## │       ├── 4
## │       └── 5
#
############################################################
##
## discussion
##
############################################################
#
# This basically has to duplicate a directory tree, but without
# any files - which I would interpret as "not even special files
# like named pipes, device files, symlinks etc" (the whole code
# would be much more complicated to handle those, albeit not
# impossible to do)
# While the example above uses absolute source and target directories,
# there is no reason why this couldn't also work with relative
# source and target as well.
# We can either do this whole thing manually or use File::Find.
# Since the latter is much more convenient, we try it here ;-)

use strict;
use warnings;
use File::Find;

my ($source, $target) = @ARGV;
die "Usage: $0 <source> <target>" unless $source and $target;

find( { "wanted" => \&wanted, "no_chdir" => 1 } , $source);

sub wanted {
   my $new = $File::Find::name;
   if(-d $new) {
      $new =~ s/^\Q$source\E/$target/;
      ensure_dir($new);
   }
}

# create a directory and all its parents if missing
sub ensure_dir {
   my $dir = shift;
   $dir =~ s/\/*$//; # remove trailing "/"
   return if -d $dir;
   if($dir =~ m/\//) {
      # we seem to have multiple parts in this path
      my $prefix = $dir;
      $prefix =~ s#/[^/]*$##;
      ensure_dir($prefix); # make sure all parents exist
   }
   mkdir $dir or die "Can't mkdir $dir: $!";
}
