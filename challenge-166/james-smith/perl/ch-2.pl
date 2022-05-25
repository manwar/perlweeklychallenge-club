#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

#        1         2         3         4         5         6         7         8         9

say 'Original - fake data';  k_diff( data() );     say '';
say 'Compact  - fake data';  k_diff( fetch() );    say '';
say 'Original - dir. data';  k( data() );          say '';
say 'Compact  - dir. data';  k( f() );             say '';
say 'Non compact';           z_diff();             say '';
say 'No comments';           z_diff_no_comments(); say '';
say 'Super compact';         z();                  say '';

##
## Data produces/fetches
##
##  * data  - function returns the data structure - simple test
##  * fetch - readable fetch function
##  * f     - compact fetch function
##

sub data {
  return (
    'dir_a' => [sort qw(Arial.ttf Backup/ Comic_Sans.ttf Consolas.otf Georgia.ttf Helvetica.ttf Impact.otf Old_Fonts/ Verdana.ttf Wingdings.ttf)],
    'dir_b' => [sort qw(Arial.ttf Backup/ Comic_Sans.ttf Consolas.otf Courier_New.ttf Helvetica.ttf Impact.otf Tahoma.ttf Verdana.ttf)],
    'dir_c' => [sort qw(Arial.ttf Backup/ Consolas.otf Courier_New.ttf Helvetica.ttf Impact.otf Monaco.ttf Verdana.ttf)],
    'dir_d' => [sort qw(Arial.ttf Backup/ Comic_Sans.ttf Consolas.otf Courier_New.ttf Helvetica.ttf Impact.otf Monaco.ttf Verdana.ttf Wingdings.ttf)],
  );
}

sub fetch {
  my(%data,$f,$sh), opendir( my $dh, '.' );
  opendir( $sh, $f=$_ ), $data{$f} = [ map { -d "$f/$_" ? "$_/" : $_ } grep { $_ ne '.' && $_ ne '..' } sort readdir $sh ]
    for grep { -d $_ && $_ ne '.' && $_ ne '..' } readdir $dh;
  %data;
}

## Super compact version of fetch {80 bytes}
#23456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
sub f{my%d;(@_=split/\//),push@{$d{$_[0]}},-d$_?"$_[1]/":$_[1]for glob'*/*';%d}

##
## Diff functions - data structure from either data(), fetch(), f() passed in
##
##  * k_diff - original diff coding
##  * k      - compact diff coding
##

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

## Super compact version of parse { 338 byes }
#23456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789
sub k{my$l=0;my(%d,$F,@p,%u,$T,$H)=@_;(length$_>$l)&&($l=length$_)for
keys%{{%u=map{$_,1}map{@{$d{$_}}}@p=sort keys%d}},@p;
say for($H=join'-'x($l+2),('+')x(1+@p)),sprintf($T='|'." %-${l}s |"x@p,@p),$H,
map({$F=$_;(grep{($d{$_}[0]//'')ne$F}@p)?sprintf$T,map{($d{$_}[0]//'')eq$F?
shift@{$d{$_}}:''}@p:map{shift@{$d{$_}};()}@p}sort keys%u),$H}


##
## Combined functions - reads directory structure as well
##
##  * z_diff             - original combined coding with comments
##  * z_diff_no_comments - original combined coding (easy to compare with z)
##  * z                  - compact combined coding
##

sub z_diff {

  ## Declare variables

    ## my($l,%d,$F,@p,%u,$T,$H)=0;
  my( $length, %directories, %filename_counts )=0;

  ## Read all sub-directories containing files and store
  ## in data structure as a hash of ordered arrays
  ## For directories add a trailing slash...

    ## (@_=split/\//),push@{$d{$_[0]}},-d$_?"$_[1]/":$_[1]for sort<*/*>;
  for( sort <*/*> ) {
    my($dir,$file) = split m{/};
    push @{ $directories{$dir}}, -d $_ ? "$file/" : $file;
  }

  ## Get out an ordered list of directories...

    ## $u{$_}++for map{@{$d{$_}}}@p=sort keys%d;
  my @paths = sort keys %directories;

  ## Find the length of the longest directory name, and
  ## keep a record of the number of times each filename
  ## has been seen (also gives list of all unique filenames)

  for my $path ( @paths ) {
    $filename_counts{ $_ }++ for @{$directories{$path}};
  }

  ## Now find the length of the longest filename or directory name
  ## This gives us the column widths for the pretty display...

    ## (length$_>$l)&&($l=length$_)for@p,keys%u;
  for ( @paths, keys %filename_counts ) {
    $length = length $_ if length $_ > $length;
  }

  ## Generate the ASCII code for a horizontal bar in the table
  ## and a template for sprintf for the rows of the table

  my $HORIZONTAL_LINE = join '-' x ( $length+2 ), ('+') x (1+@paths);
  my $TEMPLATE        = '|' . " %-${length}s |" x @paths;

  ## Draw the header {directory names} of the table....

    ## say for$H=join('-'x($l+2),('+')x(1+@p)),
    ##     sprintf($T='|'." %-${l}s |"x@p,@p),$H,
  say $HORIZONTAL_LINE;
  say sprintf $TEMPLATE, @paths;
  say $HORIZONTAL_LINE;

  ## Now draw the body - we loop through each of the unique filenames
  ## and see whether it is in all 4 columns (in which case we skip)
  ## otherwise we look to see which entries are present in each
  ## directory and show those....

    ## map({$u{$F=$_}<@p?sprintf$T,map{($d{$_}[0]//'')ne$F?'':
    ##   shift@{$d{$_}}}@p:map{shift@{$d{$_}};()}@p}sort keys%u)
  for my $filename ( sort keys %filename_counts ) {

    ## If we have seen the file in all directories - we remove
    ## it from all directory lists {and do nothing}

    if( $filename_counts{ $filename } == @paths ) {
      shift @{$_} for values %directories;
      next;
    }

    ## If we haven't we loop through the rows if
    ## the first entry is the file then we push it
    ## on the list to print {and remove it from the directory list}
    ## if not we just push an empty string to the
    ## list

    my @columns;
    for (@paths) {
      if( @{$directories{$_}} && $directories{$_}[0] eq $filename ) {
        push @columns, shift @{$directories{$_}};
      } else {
        push @columns, '';
      }
    }
    say sprintf $TEMPLATE, @columns;
  }

  ## Finally print out the bottom line

    ## $H
  say $HORIZONTAL_LINE;
}

## z_diff_no_comments - only comments left are the parts of z
## below to show how the compressed code works - in the compressed
## code some of the logic structures are replaced by ternarys
## or &&/|| for if else/if/unless, and nested loops by maps..

sub z_diff_no_comments {
  ## my($l,%d,$F,@p,%u,$T,$H)=0;
  my( $length, %directories, %filename_counts )=0;

  ## (@_=split/\//),push@{$d{$_[0]}},-d$_?"$_[1]/":$_[1]for sort<*/*>;
  for( sort <*/*> ) {
    my($dir,$file) = split m{/};
    push @{ $directories{$dir}}, -d $_ ? "$file/" : $file;
  }

  ## $u{$_}++for map{@{$d{$_}}}@p=sort keys%d;
  my @paths = sort keys %directories;
  for my $path ( @paths ) {
    $filename_counts{ $_ }++ for @{$directories{$path}};
  }

  ## (length$_>$l)&&($l=length$_)for@p,keys%u;
  for ( @paths, keys %filename_counts ) {
    $length = length $_ if length $_ > $length;
  }

  ## say for$H=join('-'x($l+2),('+')x(1+@p)),
  ##     sprintf($T='|'." %-${l}s |"x@p,@p),$H,
  my $HORIZONTAL_LINE = join '-' x ( $length+2 ), ('+') x (1+@paths);
  my $TEMPLATE        = '|' . " %-${length}s |" x @paths;
  say $HORIZONTAL_LINE;
  say sprintf $TEMPLATE, @paths;
  say $HORIZONTAL_LINE;

  ## map({$u{$F=$_}<@p?sprintf$T,map{($d{$_}[0]//'')ne$F?'':
  ##   shift@{$d{$_}}}@p:map{shift@{$d{$_}};()}@p}sort keys%u)
  for my $filename ( sort keys %filename_counts ) {
    if( $filename_counts{ $filename } == @paths ) {
      shift @{$_} for values %directories;
      next;
    }
    my @columns;
    for (@paths) {
      if( @{$directories{$_}} && $directories{$_}[0] eq $filename ) {
        push @columns, shift @{$directories{$_}};
      } else {
        push @columns, '';
      }
    }
    say sprintf $TEMPLATE, @columns;
  }

  ## $H
  say $HORIZONTAL_LINE;
}

## Merging the fetch/parse into the a single function gives us just 369 bytes
## of perlly goodness {362 without the fn call overhead}
#23456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789#
sub z{my($l,%d,$F,@p,%u,$T,$H)=0;(@_=split/\//),push@{$d{$_[0]}},-d$_?"$_[1]/":
$_[1]for sort<*/*>;$u{$_}++for map{@{$d{$_}}}@p=sort keys%d;length$_>$l?$l=
length:1for@p,keys%u;say for$H=join('-'x($l+2),('+')x(1+@p)),sprintf($T='|'.
" %-${l}s |"x@p,@p),$H,map({$u{$F=$_}<@p?sprintf$T,map{($d{$_}[0]//'')ne$F?'':
shift@{$d{$_}}}@p:map{shift@{$d{$_}};()}@p}sort keys%u),$H}

