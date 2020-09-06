#!/usr/bin/perl

# Perl Weekly Challenge - 076
# - https://perlweeklychallenge.org/blog/perl-weekly-challenge-076/
#
# Task 2 - Word Search
#
# Author: Niels 'PerlBoy' van Dijke

use strict;
use warnings;

use List::Util qw(max);

my ($gridFilename, $wordsFilename) = @ARGV;

$gridFilename //= 'grid.txt';
$wordsFilename //= 'words';  # A copy of /usr/share/dict/words

my $minLength = 5;

my @words;
my %wordsFound;
my %gridStrings;

my %directions = (
  HLR => 'Horizontal (left to right)',
  HRL => 'Horizontal (right to left)',
  VTB => 'Vertical (top to bottom)',
  VBT => 'Vertical (bottom to top)',
  DLRTB => 'Diagonal (left to right and top to bottom)',
  DLRBT => 'Diagonal (left to right and bottom to top)',
  DRLTB => 'Diagonal (right to left and top to bottom)',
  DRLBT => 'Diagonal (right to left and bottom to top)', 
);


sub readWordsFile {
  my ($fileName, $minL, $arWords) = @_;

  if (!open(fhWords,"< $fileName")) {
    die "Can't read words from '$fileName' ($!)";
  } else {
    while (<fhWords>) {
      push(@$arWords, $1) 
        if (/^([a-z]{$minL,})$/);
    }
    close(fhWords);
  }
}


sub readGridFile {
  my ($fileName, $hrGridStrings) = @_;

  my @grid;
  my @strings;

  if (!open(fhGrid, "< $fileName")) {
    die "Can't read grid from '$fileName' ($!)";
  } else {

    # Read and verify grid width input
    my $gWidth;
    my $gHeight;
    while (<fhGrid>) {
      $_ = lc($_); 
      s/[^a-z]//g; 

      $gWidth //= length($_);
      
      die "Length of line $. of grid file '$fileName' <> $gWidth [$_]"
        unless (length($_) == $gWidth);

      push(@grid, [split(//, $_)]);
    } 

    close(fhWords);

    $gHeight = scalar @grid;

    # Get horizontal,vertical and diagonal strings

    my @colStr;

    # Get horizontal and vertical strings
    for my $row (0 .. scalar @grid - 1) {
      my $s = join('', @{$grid[$row]});
      push(@{$hrGridStrings->{HLR}}, $s);
      push(@{$hrGridStrings->{HRL}}, scalar reverse $s);

      # Get vertical chars
      for my $col (0 .. $gWidth - 1) {
        $colStr[$row] .= $grid[$row][$col];
      }
    }

    # Push vertical strings
    for my $row (0 .. scalar @grid - 1) {
      push(@{$hrGridStrings->{VTB}}, $colStr[$row]);
      push(@{$hrGridStrings->{VBT}}, scalar reverse $colStr[$row]);
    } 

    # Get four diagonal direction strings 
    for my $y ($minLength - $gWidth .. $gHeight - $minLength) {
      my $diaTBLR;
      my $diaTBRL;
      for my $x (0 .. $gWidth - 1) {
        my $row = $y + $x;
        next if ($row < 0 or $row > $gHeight - 1);

        $diaTBLR .= $grid[$row][$x];
        $diaTBRL .= $grid[$row][$gWidth - 1 - $x];
      }
      push(@{$hrGridStrings->{DLRTB}}, $diaTBLR);
      push(@{$hrGridStrings->{DRLBT}}, scalar reverse $diaTBLR);
      push(@{$hrGridStrings->{DRLTB}}, $diaTBRL);
      push(@{$hrGridStrings->{DLRBT}}, scalar reverse $diaTBRL);
    }
  }
}


sub findWords {
  my ($hrGS, $arW, $hrWF) = @_;

  my @directions = keys %$hrGS;

  my $nWords = scalar(@$arW);
  my $n;
  
  print STDERR "Finding Words Progress: ";
  foreach my $word (@$arW) {
    print STDERR '.' if ($n++ % int($nWords / 50) == 0);
    foreach my $direction (@directions) {
      foreach my $str (@{$hrGS->{$direction}}) {
        $hrWF->{$word}{$direction}++
          if ($str =~ m#$word#);
      }
    }
  }
  print STDERR "\n";
}


sub printReport {
  my ($arWords, $minL, $hrWordsFound) = @_;

  my @directions = sort keys %directions;
  my $maxWlen = max(map { length $_} keys %$hrWordsFound);

  my $rowFmt = "%-${maxWlen}s | %5s | %5s | %5s | %5s | %5s | %5s | %5s | %5s\n"; 

  my $sepFmt = $rowFmt; $sepFmt =~ tr/\|/+/;
  my $sep = sprintf $sepFmt, '-' x $maxWlen, map { '-' x 5 } @directions;

  printf "\n%d uniq words found in grid of length %d or more (using dictionary containing %d words).\n\n", 
         scalar keys %$hrWordsFound, $minL, scalar @$arWords;

  printf $rowFmt, 'Word', @directions;
  print $sep;

  foreach my $word (sort keys %$hrWordsFound) {
    my @values = map { $hrWordsFound->{$word}{$_} // '' } @directions; 
    printf $rowFmt, 
           $word,
           @values;
  }
  printf "$sep\n";

  my @legendW = ( 
    max(map { length } @directions),
    max(map { length } values %directions)
  );
  my $legendFmt = sprintf("%%-%ds | %%-%ds\n", @legendW);
  $sepFmt = $legendFmt; $sepFmt =~ tr/\|/+/;
  $sep =  sprintf $sepFmt, map { '-' x $_ } @legendW;

  print "Legend:\n";
  print "=======\n";
  print "\n";
  printf $legendFmt, qw(Key Description);
  printf $sep;
  foreach my $direction (@directions) {
    printf $legendFmt, $direction, $directions{$direction};
  } 
  printf $sep;
}


readWordsFile($wordsFilename, $minLength, \@words);
readGridFile($gridFilename, \%gridStrings);
findWords(\%gridStrings, \@words, \%wordsFound);
printReport(\@words, $minLength, \%wordsFound);

