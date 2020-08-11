#!/usr/bin/env perl
use v5.10;
use strict;
use warnings;

# Sorry, couldn't resist doing *something* more than the more obvious
# solutions...
say join( ":", map { sprintf "%02d", $_ } reverse( (localtime)[ 0 .. 2 ] ) );
