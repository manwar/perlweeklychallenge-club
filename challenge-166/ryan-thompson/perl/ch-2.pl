#!/usr/bin/env perl
#
# dirdiff - Compare two or more directories and report differences
#
# 2003-2021 Ryan Thompson <rjt@cpan.org>

use 5.010;
use warnings;
use strict;
no warnings 'uninitialized';

use File::Slurp qw< read_dir >;
use List::Util  qw< uniq all max >;

die "Usage: $0 dir1 dir2 ..." if @ARGV < 2;

my @dirs = @ARGV; # Preserve order
my %dirs = read_all_dirs(@dirs);
my @uniq = uniq sort map { keys %{$dirs{$_}{files}} } keys %dirs;

# This format string is used for headings and directory contents
my $fmt = join(" | ", map { "%-$dirs{$_}{maxlen}s" } @dirs) . "\n";

printf $fmt, @dirs;
printf $fmt, map { '-' x $dirs{$_}{maxlen} } @dirs; # Divider

# Main event: Output files that do not exist in all @dirs
for my $file (@uniq) {
    my @files = map { $dirs{$_}{files}{$file} ? $file : '' } @dirs;
    next if all { length } @files; # Exists in all directories

    printf $fmt, @files;
}

# Read all dirs, calculate their max filename length, and return the works
# $result{dir1}{files}{fileA} = 1 if fileA exists in dir1
# $result{dir1}{maxlen} = maximum filename length in dir1
sub read_all_dirs {
    map {
        my $dir = $_;
        my %hash = map  { $_ => 1 } 
                   map  { -d "$dir/$_" ?  "${_}/" : $_ }
                   grep { -f "$dir/$_" or -d "$dir/$_" } read_dir($dir);

        $dir => {
            files  => \%hash,
            maxlen => max map length, keys %hash, $dir
        }
    } @_ 
}
