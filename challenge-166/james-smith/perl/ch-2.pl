#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

sub data {
  return (
    'dir_a' => [sort qw(Arial.ttf Backup/ Comic_Sans.ttf Consolas.otf Georgia.ttf Helvetica.ttf Impact.otf Old_Fonts/ Verdana.ttf Wingdings.ttf)],
    'dir_b' => [sort qw(Arial.ttf Backup/ Comic_Sans.ttf Consolas.otf Courier_New.ttf Helvetica.ttf Impact.otf Tahoma.ttf Verdana.ttf)],
    'dir_c' => [sort qw(Arial.ttf Backup/ Consolas.otf Courier_New.ttf Helvetica.ttf Impact.otf Monaco.ttf Verdana.ttf)],
    'dir_d' => [sort qw(Arial.ttf Backup/ Comic_Sans.ttf Consolas.otf Courier_New.ttf Helvetica.ttf Impact.otf Monaco.ttf Verdana.ttf Wingdings.ttf)],
  );
}


sub fetch {
  my(%data,$f,$sh),opendir( my $dh, '.' );
  opendir( $sh, $f=$_ ), $data{$f} = [ map { -d "$f/$_" ? "$_/" : $_ } grep { $_ ne '.' && $_ ne '..' } sort readdir $sh ]
    for grep { -d $_ && $_ ne '.' && $_ ne '..' } readdir $dh;
  %data;
}
k_diff(  data ); kc(  data );
k_diff( fetch ); kc( fetch );

sub k_diff {
  my ($len,%dir,$F,$T) = (0,@_);

  ## Get a sorted list of directory name & unique list of flies....
  my %unique_files = map { $_ => 1 } map { @{$dir{$_}} } (my @paths = sort keys %dir);

  ## Find the length of the longest directory/file name....
  (length $_ > $len ) && ( $len = length $_ ) for @paths, keys %unique_files;

  ## Create the template for printing a padded string & the line between header/body of table...
  my $TEMPLATE = '|'." %-${len}s |" x @paths;
  my $LINE     = "+-@{[ join '-+-', map{ '-' x $len } @paths ]}-+";

  ## Output results as a table with line - header - line - rows - line....
  say $LINE;
  say sprintf $TEMPLATE, @paths;
  say $LINE;

  ## Nasty and the meat of the display challenge.....
  ##  first line  - checks to see if we have the line we have to display
  ##  second line - displays the files which are present
  ##  third line  - if all the same shift them off the front of the lists...

  $F = $_, ( grep { ($dir{$_}[0]//'') ne $F } @paths )
    ? ( say sprintf $TEMPLATE, map { ($dir{$_}[0]//'') eq $F ? shift @{$dir{$_}} : '' } @paths )
    : ( map { shift @{$dir{$_}} } @paths ) for sort keys %unique_files;

  ## Just finish of the table!
  say $LINE;
}

sub kc{my$l=0;my(%d,$F,@p,%u,$T,$L)=@_;
(length$_>$l)&&($l=length$_)for(@p=sort keys%d),keys%{{%u=map{$_,1}map{@{$d{$_}}}@p}};
say for($T='|'." %-${l}s |"x@p)x 0,$L="+-@{[join'-+-',map{'-'x$l}@p]}-+",sprintf($T,@p),$L,
map({$F=$_;(grep{($d{$_}[0]//'')ne$F}@p)?(sprintf$T,map{($d{$_}[0]//'')eq$F?shift@{$d{$_}}:''}@p):
map{shift@{$d{$_}};()}@p}sort keys%u),$L}

