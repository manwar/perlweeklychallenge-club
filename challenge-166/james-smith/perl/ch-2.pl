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

#        1         2         3         4         5         6         7         8         9
#23456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
## Super compact version of fetch {79 bytes}
sub f{my%d;(@_=split/\//),push@{$d{$_[0]}},-d$_?"$_[1]/":$_[1]for glob'*/*';%d}

## Super compact version of parse { 338 byes }
sub k{my$l=0;my(%d,$F,@p,%u,$T,$H)=@_;(length$_>$l)&&($l=length$_)for
keys%{{%u=map{$_,1}map{@{$d{$_}}}@p=sort keys%d}},@p;
say for($H=join'-'x($l+2),('+')x(1+@p)),sprintf($T='|'." %-${l}s |"x@p,@p),$H,
map({$F=$_;(grep{($d{$_}[0]//'')ne$F}@p)?sprintf$T,map{($d{$_}[0]//'')eq$F?
shift@{$d{$_}}:''}@p:map{shift@{$d{$_}};()}@p}sort keys%u),$H}

## Merging the fetch/parse into the same function gives us juset 398 bytes of
## perlly goodness.....

sub z{my($l,%d,$F,@p,%u,$T,$H)=0;(@_=split/\//),push@{$d{$_[0]}},-d$_?"$_[1]/":
$_[1]for glob'*/*';(length$_>$l)&&($l=length$_)for keys%{{%u=map{$_,1}
map{@{$d{$_}}}@p=sort keys%d}},@p;say for($H=join'-'x($l+2),('+')x(1+@p)),
sprintf($T='|'." %-${l}s |"x@p,@p),$H,map({$F=$_;(grep{($d{$_}[0]//'')ne$F}@p)?
sprintf$T,map{($d{$_}[0]//'')eq$F?shift@{$d{$_}}:''}@p:map{shift@{$d{$_}};()}@p
}sort keys%u),$H}

# 334 bytes - to work out unique files, work out the column width, and print out
# those files which are not in all the directories


sub fetch {
  my(%data,$f,$sh), opendir( my $dh, '.' );
  opendir( $sh, $f=$_ ), $data{$f} = [ map { -d "$f/$_" ? "$_/" : $_ } grep { $_ ne '.' && $_ ne '..' } sort readdir $sh ]
    for grep { -d $_ && $_ ne '.' && $_ ne '..' } readdir $dh;
  %data;
}
say 'Original - fake data';  k_diff(  data ); say '';
say 'Original - dir. data';  k( data );       say '';
say 'Compact  - fake data';  k_diff( fetch ); say '';
say 'Compact  - dir. data';  k( f );          say '';
say 'Super compact';         z;          say '';

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

