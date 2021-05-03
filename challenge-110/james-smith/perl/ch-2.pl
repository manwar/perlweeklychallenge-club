#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Data::Dumper;
use Const::Fast qw(const);
use Time::HiRes qw(time);
const my $FN_TINY  => 'in.txt';
#const my $FN_SMALL => 'in-large.txt';
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

if($ARGV[0] ==  1) {  $t0 = time; transpose_seek(  $FN_TINY,    'seek-small'  ); say 'Seek small    - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] ==  2) {  $t0 = time; transpose_regex( $FN_TINY,    'regex-small' ); say 'Regex small   - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] ==  3) {  $t0 = time; transpose_split( $FN_TINY,    'split-small' ); say 'Split small   - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] ==  4) {  $t0 = time; transpose_seek(  $FN_SMALL,   'seek-1000'   ); say 'Seek 1000     - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] ==  5) {  $t0 = time; transpose_seek(  $FN_MEDIUM,  'seek-2000'   ); say 'Seek 2000     - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] ==  6) {  $t0 = time; transpose_seek(  $FN_LARGE,   'seek-5000'   ); say 'Seek 5000     - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] ==  7) {  $t0 = time; transpose_regex( $FN_SMALL,   'regex-1000'  ); say 'Regex 1000    - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] ==  8) {  $t0 = time; transpose_seek(  $FN_MASSIVE, 'seek-30000'  ); say 'Seek 30000    - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] ==  9) {  $t0 = time; transpose_regex( $FN_MEDIUM,  'regex-2000'  ); say 'Regex 2000    - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] == 10) {  $t0 = time; transpose_split( $FN_SMALL,   'split-1000'  ); say 'Split 1000    - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] == 11) {  $t0 = time; transpose_regex( $FN_LARGE,   'regex-5000'  ); say 'Regex 5000    - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] == 12) {  $t0 = time; transpose_split( $FN_MEDIUM,  'split-2000'  ); say 'Split 2000    - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }
if($ARGV[0] == 13) {  $t0 = time; transpose_split( $FN_LARGE,   'split-5000'  ); say 'Split 5000    - Time: ',sprintf('%13.6f',time-$t0),' ',get_statm_info(); }

sub transpose_split {
  ## Slurp into array
  open my $fh, '<', $_[0];
  my @in =  map { chomp;[ split /,/ ] } <$fh>;
  close $fh;
  ## Generate transpose
  open $fh, '>', $_[1];
  say {$fh} join ',', map {shift @{$_} } @in while @{$in[0]};
  close $fh;
}

sub transpose_regex {
  ## Slurp into array
  open my $fh, '<', $_[0];
  my @in = <$fh>;
  close $fh;
  ## Generate transpose
  open $fh, '>', $_[1];
  say {$fh} join ',', map { s{^(.*?)[,\r\n]+}{}; $1 } @in while $in[0];
  close $fh;
}

sub transpose_seek {
  my ( $prev, @pos ) = ( 0 );

  ## Loop through the file and get the start/end position of each line,
  ## and the first $BYTES characters of each line...

  open my $fh,  '<', $_[0];

  ( push @pos, [ $prev+$BYTES, tell $fh, substr $_, 0, $BYTES ] ) &&
    ( $prev = tell $fh ) while <$fh>;

  ## While we still have "columns" loop through each row and grab the first
  ## entry and output results.

  open my $ofh, '>', $_[1];  ## Need 2 file handles open at once for this.

  while( $pos[0][0] < $pos[0][1] || length $pos[0][2] ) {
    my $j = '';
    foreach( @pos ) {
      ## Grab extra data for the row if we have got an incomplete
      ## field {missing a "," and still data to read}
      while( $_->[2] !~ m{,} && $_->[0] < $_->[1] ) {
        seek $fh, $_->[0], 0;  ## 0 = from start of file!
        read $fh,
             $_->[2],    ## "Buffer"
             $_->[1]-$_->[0] > $BYTES ? $BYTES : $_->[1]-$_->[0],
             length $_->[2];  ## Length of "Buffer" so text gets
                              ## added to end
        $_->[0] += $BYTES;
      }
      $_->[2] =~ s{^([^,\r\n]+)[,\r\n]*}{};
      print {$ofh} $j, $1;
      $j ||= ',';
    }
    say {$ofh} '';
  }
}

sub get_statm_info {
  ## Support function gets the in memory size of the current process
  ## we use this to show how efficient memory usage is...
  my $error = '';
  my $ref = {};

  if( open(_INFO,"</proc/$$/statm") ){
    my @info = split(/\s+/,<_INFO>);
    close(_INFO);
    return sprintf 'Size: %8d, Resident: %8d, Shared: %8d',
      $info[0]*4, $info[1]*4, $info[2]*4;
  }
  return '-';
}
