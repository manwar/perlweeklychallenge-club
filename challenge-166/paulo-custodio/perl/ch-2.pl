#!/usr/bin/env perl

# Challenge 166
#
# Task 2: K-Directory Diff
# Submitted by: Ryan J Thompson
#
# Given a few (three or more) directories (non-recursively), display a
# side-by-side difference of files that are missing from at least one of the
# directories. Do not display files that exist in every directory.
#
# Since the task is non-recursive, if you encounter a subdirectory, append a /,
# but otherwise treat it the same as a regular file.
# Example
#
# Given the following directory structure:
#
# dir_a:
# Arial.ttf  Comic_Sans.ttf  Georgia.ttf  Helvetica.ttf  Impact.otf  Verdana.ttf
# Old_Fonts/
#
# dir_b:
# Arial.ttf  Comic_Sans.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf
# Tahoma.ttf  Verdana.ttf
#
# dir_c:
# Arial.ttf  Courier_New.ttf  Helvetica.ttf  Impact.otf  Monaco.ttf  Verdana.ttf
#
# The output should look similar to the following:
#
# dir_a          | dir_b           | dir_c
# -------------- | --------------- | ---------------
# Comic_Sans.ttf | Comic_Sans.ttf  |
#                | Courier_New.ttf | Courier_New.ttf
# Georgia.ttf    |                 |
#                |                 | Monaco.ttf
# Old_Fonts/     |                 |
#                | Tahoma.ttf      |

use Modern::Perl;

use constant WIDTH => 16;

sub read_dir {
    my($dir)=@_;
    opendir(my $d, $dir) or die "opendir $dir: $!";
    return sort
           map  {-d "$dir/$_" ? "$_/" : $_ }
           grep {$_ ne "." && $_ ne ".."} readdir($d);
}

sub read_dirs {
    my(@dirs)=@_;
    return map {[read_dir($_)]} @dirs;
}

sub print_line {
    my(@cells)=@_;
    for my $i (0..$#cells) {
        printf("%-*s", WIDTH, $cells[$i]);
        print " | " if $i!=$#cells;
    }
    print "\n";
}

sub print_diff {
    my($dirs, @contents)=@_;

    # print header
    print_line(@$dirs);
    print_line(("-" x WIDTH) x scalar(@$dirs));

    # collect files
    my %files;
    my %files_dir;
    for my $i (0..$#$dirs) {
        my $dir=$dirs->[$i];
        my @files=@{$contents[$i]};
        for my $file (@files) {
            $files{$file}++;
            $files_dir{$file}{$dir}++;
        }
    }

    # print rows
    for my $file (sort keys %files) {
        my @row;
        for my $i (0..$#$dirs) {
            my $dir=$dirs->[$i];
            push @row, $files_dir{$file}{$dir} ? $file : "";
        }
        print_line(@row) if grep {$_ eq ""} @row;
    }
}

@ARGV>1 or die "usage: ch-1.pl dir...\n";
print_diff(\@ARGV, read_dirs(@ARGV));
