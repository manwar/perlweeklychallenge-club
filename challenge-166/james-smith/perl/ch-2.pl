#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use Benchmark qw(cmpthese timethis);
use Data::Dumper qw(Dumper);

#        1         2         3         4         5         6         7         8         9
say 'Super compact';         x();                  say '';
say 'Super compact';         z();                  say '';
say 'Super compact';         g();                  say '';
#say 'No comments';           z_diff_no_comments(); say '';

exit;
say 'Original - fake data';  k_diff( data() );     say '';
say 'Compact  - fake data';  k_diff( fetch() );    say '';
say 'Original - dir. data';  k( data() );          say '';
say 'Compact  - dir. data';  k( f() );             say '';
say 'Non compact';           z_diff();             say '';

##  * z_diff             - original combined coding with comments
##  * z_diff_no_comments - original combined coding (easy to compare with z)
##  * z                  - compact combined coding
##

sub z_diff {

  ## Declare variables

    ## my($l,%d,$F,@p,%u,$T,$H)=0;
  my( $length, %directories, %filenames)=0;

  ## Read all sub-directories containing files and store
  ## in data structure as a hash of ordered arrays
  ## For directories add a trailing slash...

    ## (@_=split/\//),push@{$d{$_[0]}},-d$_?"$_[1]/":$_[1]for sort<*/*>;
  for( sort <*/*> ) {
    my( $dir, $file ) = split m{/}, $_;
    $directories{$dir}=1;
    $file.='/' if -d $_;
    $filenames{ $file }{ $dir } = 1;
  }

  ## Now find the length of the longest filename or directory name
  ## This gives us the column widths for the pretty display...

    ## (length$_>$l)&&($l=length$_)for@p,keys%u;
  my @paths = sort keys %directories;
  for ( @paths, keys %filenames ) {
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
  for my $filename ( sort keys %filenames ) {

  ## Foreach filename - we first see it is in all columns,
  ## If it is we display the filename in the appropriate columnns.

    next if @paths == keys %{$filenames{$filename}};
    my @columns;
    for (@paths) {
      if( exists $filenames{$filename}{$_} ) {
        push @columns, $filename;
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
  my( $length, %directories, %filenames )=0;

  ## /\//,$u{$'.'/'x-d}{$d{$`}=$`}++for<*/*>;
  for( sort <*/*> ) {
    my( $dir, $file ) = split m{/}, $_;
    $directories{$dir}=1;
    $file.='/' if -d $_;
    $filenames{ $file }{ $dir } = 1;
  }

  ## (length$_>$l)&&($l=length$_)for(@p=sort keys%d),keys%u;
  my @paths = sort keys %directories;
  for ( @paths, keys %filenames ) {
    $length = length $_ if length $_ > $length;
  }

  ## say for$H=join('-'x($l+2),('+')x(1+@p)),
  ##     sprintf($T='|'." %-${l}s |"x@p,@p),$H,
  my $HORIZONTAL_LINE = join '-' x ( $length+2 ), ('+') x (1+@paths);
  my $TEMPLATE        = '|' . " %-${length}s |" x @paths;
  say $HORIZONTAL_LINE;
  say sprintf $TEMPLATE, @paths;
  say $HORIZONTAL_LINE;

  ## map({$l=$_;@p>keys%{$u{$l}}?sprintf$b,map{$u{$l}{$_}?$l:''}@p:()}sort@_)
  for my $filename ( sort keys %filenames ) {
    next if @paths == keys %{$filenames{$filename}};
    my @columns;
    for (@paths) {
      if( exists $filenames{$filename}{$_} ) {
        push @columns, $filename;
      } else {
        push @columns, '';
      }
    }
    say sprintf $TEMPLATE, @columns;
  }

  ## $H
  say $HORIZONTAL_LINE;
}

## Merging the fetch/parse into the a single function gives us just 259 bytes
## of perlly goodness {252 without the fn call overhead}

#23456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789#
sub g{my($l,%d,%u)=0;/\//,$u{$'.'/'x-d}{$d{$`}=$`}++for<*/*>;$l<length?$l=length
:1for(my@p=sort keys%d),@_=keys%u;say$a=join('-'x$l,('+--')x@p,"+\n"),sprintf($b
="| %-${l}s "x@p."|\n",@p),$a,map({//;@p-%{$u{$'}}?sprintf$b,map{$u{$'}{$_}?$':
''}@p:()}sort@_),$a}

sub x{
  my($l,%d,%u)=0;
  /\//,$u{$'.'/'x-d}{$d{$`}=$`}++ for <*/*>;
  $l<length?$l=length:1 fo r(my@p=sort keys%d), @_=keys%u;
  say $a=join( '-'x$l,('+--')x@p,"+\n" ),
      sprintf( $b="| %-${l}s "x@p."|\n", @p ),
      $a,
      map( {//;@p-%{$u{$'}}?sprintf$b,map{$u{$'}{$_}?$':''}@p:() } sort @_ ),
      $a
}

## 257 bytes (250 without fn overhead)
#23456789 123456789 123456789 123456789 123456789 123456789 123456789 123456789#
sub z{my($l,%d,%u)=0;/\//,$u{$'.'/'x-d}{$d{$`}=$`}++for<*/*>;$l<length?$l=length
:1for(my@p=sort keys%d),@_=keys%u;say$a=join('-'x$l,('+--')x@p,'+
'),sprintf($b="| %-${l}s "x@p.'|
',@p),$a,map({//;@p-%{$u{$'}}?sprintf$b,map{$u{$'}{$_}?$':''}@p:()}sort@_),$a}
