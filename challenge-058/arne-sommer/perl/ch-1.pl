#! /usr/bin/env perl

use version;
use feature say;

say version->parse( $ARGV[0] ) <=> version->parse( $ARGV[1] );
