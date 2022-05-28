#!/bin/perl

=pod

The Weekly Challenge - 166
 - https://theweeklychallenge.org/blog/perl-weekly-challenge-166/#TASK2

Author: Niels 'PerlBoy' van Dijke

Task 2: K-Directory Diff
Submitted by: Ryan J Thompson

Given a few (three or more) directories (non-recursively), display a side-by-side 
difference of files that are missing from at least one of the directories. Do not 
display files that exist in every directory.

Since the task is non-recursive, if you encounter a subdirectory, append a /, but 
otherwise treat it the same as a regular file.

=cut

use v5.16;

use List::Util qw(max);
use Data::Printer;

@ARGV = (grep {-d } glob('*')) unless @ARGV;

kDirDiff(@ARGV);

sub kDirDiff (@) {
  my (@dirs) = sort @_;

  my %dirEntries;
  my %maxLength;

  # Build filelist presence map 
  for my $dir (@dirs) {
    $maxLength{$dir} = length($dir);
    opendir(D, $dir);
    map { 
      $_ .= '/' if (-d "$dir/$_");
      $dirEntries{$_}{$dir}++;
      $maxLength{$dir} = max($maxLength{$dir}, length($_));
    } readdir(D);
  }

  # Create report
  my $fmt = join(' | ', map { "%-$maxLength{$_}s" } sort keys(%maxLength))."\n";
 
  printf($fmt, @dirs);
  printf($fmt =~ tr/ /-/r, map { '-' x $maxLength{$_} } @dirs);
  foreach my $f (sort keys %dirEntries) {
    printf($fmt, map { exists $dirEntries{$f}{$_} ? $f : '' } @dirs)
      unless (scalar @dirs == scalar keys %{$dirEntries{$f}});
  }
}
