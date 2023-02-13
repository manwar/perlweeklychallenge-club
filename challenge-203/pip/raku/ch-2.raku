#!/usr/bin/env raku
# HTTPS://TheWeeklyChallenge.Org - Perl/Raku Weekly Challenge #203 - Pip Stuart
# Task2: Copy Directory:  Submitted by: Julien Fiegehenn;  You are given path to two folders, $source and $target.
# Write a script that recursively copy the directory from $source to $target except any files.
# Example1:
#   In-put: $source = '/a/b/c' and $target = '/x/y'
#   Source directory structure:
#   ├── a
#   │   └── b
#   │       └── c
#   │           ├── 1
#   │           │   └── 1.txt
#   │           ├── 2
#   │           │   └── 2.txt
#   │           ├── 3
#   │           │   └── 3.txt
#   │           ├── 4
#   │           └── 5
#   │               └── 5.txt
#   Target directory structure:
#   ├── x
#   │   └── y
#   Expected Result:
#   ├── x
#   │   └── y
#   |       ├── 1
#   │       ├── 2
#   │       ├── 3
#   │       ├── 4
#   │       └── 5
# Last date to submit the solution 23:59 (UK Time) Sunday 12th February 2023.
use v6;my $d8VS='N2AL1TnR';
sub CpDr {my $srcd=shift(@_) || die "!*EROR*! Need a source directory to copy! $!";
          my $trgd=shift(@_) || ''; # deciding to just make absolute paths relative to current-working-directory for testing to avoid using Oper8ngSys root /;
  $srcd ~~ s|^\.?\/*|./|;$srcd ~~ s|([^.])\/+$|$1|;
  $trgd ~~ s|^\.?\/*|./|;$trgd ~~ s|([^.])\/+$|$1|;
  printf("%-16s => $trgd;\n",$srcd);
  for  dir("$srcd/") {
    if ($_.IO ~~ :d) {
      my   $subd = $_;$subd ~~ s|.*\/||;
      mkdir(   "$trgd/$subd", 0o755);
      CpDr ($_,"$trgd/$subd"); } } # recursively copy subdirectories only;
  return(       $trgd );
}
if    (@*ARGS) {
  CpDr(@*ARGS);
} else {
  CpDr('/a/b/c', '/x/y');
}
