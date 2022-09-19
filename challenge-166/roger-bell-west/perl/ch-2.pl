#! /usr/bin/perl

use strict;
use warnings;

use experimental 'signatures';

sub kdd(@dirlist0) {
  my @dirlist = sort @dirlist0;
  my %fx;
  foreach my $d (@dirlist) {
    opendir (my $dh,$d);
    foreach my $entry (grep !/^\./,readdir $dh) {
      my $nn = $entry;
      if (-d "$d/$entry") {
        $nn .= '/';
      }
      $fx{$nn}{$d} = 1;
    }
    closedir $dh;
  }
  my $mm=scalar @dirlist;
  my @out=(\@dirlist);
  foreach my $f (sort keys %fx) {
    unless (scalar keys %{$fx{$f}} == $mm) {
      my @l;
      foreach my $d (@dirlist) {
        if (exists $fx{$f}{$d}) {
          push @l,$f;
        } else {
          push @l,'';
        }
      }
      push @out,\@l;
    }
  }
  return \@out;
}


sub tabular($d) {
  my @columnlength;
  foreach my $row (@{$d}) {
    foreach my $colno (0..$#{$row}) {
      if (!defined($columnlength[$colno]) ||
          $columnlength[$colno] < length($row->[$colno])) {
        $columnlength[$colno]=length($row->[$colno]);
      }
    }
  }
  my $format=join(' | ',map {"%-${_}s"} @columnlength);
  my $result='';
  foreach my $row (@{$d}) {
    $result .= sprintf($format,@{$row})."\n";
  }
  return $result;
}

print tabular(kdd("dir_a","dir_b","dir_c"));
