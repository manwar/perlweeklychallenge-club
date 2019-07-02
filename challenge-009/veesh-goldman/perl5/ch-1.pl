#!/usr/bin/perl

use feature 'say';
use List::Util qw/uniq first/;

say first { 5 <= uniq split //, $_ **2 } 1..10000
