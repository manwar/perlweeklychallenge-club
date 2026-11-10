#!/usr/bin/env perl
use strict;
use warnings;
use Test::More tests => 5;

sub longest_absolute_path{
  my ($fs) = @_;
  my @lines = grep{length} split /\n/,$fs;
  my @depth = map{/^(\t*)/; length $1} @lines;
  my ($best,@len) = (0);
  
  foreach my $i(0..$#lines){
    my $d = $depth[$i];
    my $name = substr($lines[$i],$d);
    $len[$d] = ($d > 0 ? $len[$d-1]+1 : 0) + length $name;
    my $is_dir = ($i < $#lines && $depth[$i+1] > $d);
    if(!$is_dir && index($name,'.') >= 0){
      $best = $len[$d] if $len[$d] > $best
    }
  }
  $best
}

is longest_absolute_path("dir\n\tsubdir1\n\t\tsubsubdir1\n\tsubdir2"),0,'Example 1';
is longest_absolute_path("file1.txt\nfile2.ext\na.png"),9,'Example 2';
is longest_absolute_path("my documents\n\tproject v1.0\n\t\tnotes v1.txt\n\timage.png"),38,'Example 3';
is longest_absolute_path("root\n\ta\n\t\tb\n\t\t\tc.txt\n\td\n\t\te.txt"),14,'Example 4';
is longest_absolute_path("a\n\tb\n\t\tc\n\t\t\td\n\t\t\t\te.txt\n\tvery_long_directory_name\n\t\tf.txt"),32,'Example 5';

