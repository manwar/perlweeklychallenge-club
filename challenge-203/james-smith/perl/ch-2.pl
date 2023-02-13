#!/usr/local/bin/perl

use strict;
use warnings;
use feature qw(say);

copy_dir( 't/a', 't/x/y' );

## Rather than recursion we will use a directory path
## queue - if we find a directory - we make the copy
## and then queue it to see if it has any sub-directories

sub copy_dir {
  my( $from_dir, $to_dir , @path_queue ) = ( @_, '/' );
  return unless -d $from_dir && -d $to_dir;
  while( my $path = shift @path_queue ) {
    opendir my $dh,      $from_dir.$path;
    $_ ne '.' && $_ ne '..'
              && -d      $from_dir.$path.$_
              && mkdir(    $to_dir.$path.$_.'/' )
              && push @path_queue, $path.$_.'/'
      for readdir $dh;
    closedir $dh;
  }
}
