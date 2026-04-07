#!/usr/bin/env perl

# Perl Weekly Challenge 166 - Task 2 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-166/

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
