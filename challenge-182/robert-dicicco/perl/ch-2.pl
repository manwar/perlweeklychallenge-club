#!perl.exe

use strict;
use warnings;
use File::Basename;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-12
# Challenge 182 Common Path ch-2.pl ( Perl )

my @dirs = qw(

  /a/b/c/1/x.pl

  /a/b/c/d/e/2/x.pl

  /a/b/c/d/3/x.pl

  /a/b/c/4/x.pl

  /a/b/c/d/5/x.pl

);

my $dir_cnt = scalar @dirs;         # number of directory entries

my $test = dirname($dirs[0]);       # get first dir entry

print("Input:\n");

foreach(@dirs){

  print("\t$_\n");

}

my $flag = 1;

while($flag == 1){

  my @pieces = split('/',$test);    # split it

  splice(@pieces, 0,1);             # remove blank on fron end

  splice(@pieces, -1,1);            # remove file name from back end

  my $count = 0;

  my $test_path = join('/',@pieces);

  $test_path = "/" . $test_path . "/";

  print("Output:\n");

  print("\t$test_path\n");

  my $n = 0;

  foreach (@dirs) {

    if ($_ =~ /$test_path/){      # if dir entry contains $test_path

      $n++;

      $flag = 0 if ($n == $dir_cnt);  # exit if all lines contain $test_path

    }

  }

  $test = $test_path;             # else, go around again

}
