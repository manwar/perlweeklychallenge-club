#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Data::Dumper;
use Const::Fast qw(const);
use Time::HiRes qw(time);
const my $FN_TINY  => 'in.txt';
#const my $FN2 => 'in-large.txt';
const my $FN_SMALL   => 'in-1000.txt';
const my $FN_MEDIUM  => 'in-2000.txt';
const my $FN_LARGE   => 'in-5000.txt';
const my $FN_MASSIVE => 'in-30000.txt';
const my $BYTES => 1_024;

select(STDOUT); $| = 1;

## For a small file we can use just about any valid technique...
## But here I will look at some different techniques which can
## be more efficient with medium, large data files.
##
## Some of these are a trade off between performance and
##
## At work we have large 2d arrays of data - e.g. genes vs samples,
## variations vs genes - often both dimensions are in the range 20,000
## lines or more. So we need to look at faster - alternative less
## memory intense solutions
##
## The last function transpose_seek - was my solution to speeding
## up a python script
##
## Python 3 -> Python 2 sped things up by a factor or 4, the perl
## rewrite sped things up by a factor of 100 for the size of arrays
## we were looking at.

my $t0;

   $t0 = time; transpose_seek(  $FN,  'seek-small'  ); say 'Seek small  ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_regex( $FN,  'regex-small' ); say 'Regex small ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_split( $FN,  'split-small' ); say 'Split small ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_seek(  $FN2, 'seek-1000'   ); say 'Seek 1000   ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_seek(  $FN3, 'seek-2000'   ); say 'Seek 2000   ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_seek(  $FN4, 'seek-5000'   ); say 'Seek 5000   ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_regex( $FN2, 'regex-1000'  ); say 'Regex 1000  ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_seek(  $FN5, 'seek-30000'  ); say 'Seek 30000  ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_regex( $FN3, 'regex-2000'  ); say 'Regex 2000  ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_split( $FN2, 'split-1000'  ); say 'Split 1000  ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_regex( $FN4, 'regex-5000'  ); say 'Regex 5000  ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_split( $FN3, 'split-2000'  ); say 'Split 2000  ',time-$t0,' ',get_statm_info();
   $t0 = time; transpose_split( $FN4, 'split-5000'  ); say 'Split 5000  ',time-$t0,' ',get_statm_info();

sub transpose_split {
  open my $fh, '<', $_[0];
  my @in =  map { chomp;[ split /,/ ] } <$fh>;                 ## Slurp into array
  close $fh;
  open $fh, '>', $_[1];
  say {$fh} join ',', map {shift @{$_} } @in while @{$in[0]};        ## Generate transpose;
  close $fh;
}

sub transpose_regex {
  open my $fh, '<', $_[0];
  my @in = <$fh>;                                              ## Slurp into array
  close $fh;
  open $fh, '>', $_[1];
  say {$fh} join ',', map { s{^(.*?)[,\r\n]+}{}; $1 } @in while $in[0];
  close $fh;
}

sub transpose_seek {
  my($prev,@pos) = (0);
  open my $fh, '<', $_[0];
  open my $ofh, '>', $_[1];
  ## Loop through the file and get the start/end of each line
  push (@pos, [$prev+$BYTES,tell $fh,substr $_,0,$BYTES]) && (($pos[-1][0]>$pos[-1][1])&&($pos[-1][0]=$pos[-1][1]), $prev=tell $fh) while <$fh>;

  while( $pos[0][0] < $pos[0][1] || length $pos[0][2] ) {
    my @line;
    foreach(@pos) {
      while( $_->[2] !~ m{,} && $_->[0] < $_->[1] ) {
        seek $fh, $_->[0], 0;
        read $fh, $_->[2], $_->[1]-$_->[0] > $BYTES ? $BYTES : $_->[1]-$_->[0], length $_->[2];
        $_->[0] = tell $fh;
      }
      $_->[2] =~ s{^([^,\r\n]+)[,\r\n]*}{};
      push @line, $1;
    }
    say ${$ofh} join q(,), @line;
  }
}

sub get_statm_info {
  my $error = '';
  my $ref = {};

  if( open(_INFO,"</proc/$$/statm") ){
    my @info = split(/\s+/,<_INFO>);
    close(_INFO);
    return sprintf 'Size: %d, Resident: %d, Shared: %d', $info[0]*4, $info[1]*4, $info[2]*4;
  }
  return '-';
}
