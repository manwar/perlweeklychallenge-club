#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);

say join ', ', all_binary($_) for 1..10;

sub all_binary {                             ## Make a template so we don't have
  my $t = "%0$_[0]b";                        ## to do interpolation everytime
  map { sprintf $t, $_ } 0 .. (1<<$_[0])-1   ## Need brackets as - is actioned                                         
}                                            ## before <<.

