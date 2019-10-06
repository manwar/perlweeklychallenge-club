#!/usr/bin/env perl
# Author: Steven Wilson
# Date: 2019-10-01
# Week: 028

# Task #1
# Write a script to check the file content without explicitly reading
# the content. It should accept file name with path as command line
# argument and print “The file content is binary.” or else “The file
# content is ascii.” accordingly.


use strict;
use warnings;
use feature qw/ say /;
use File::Type;


my $filename = $ARGV[0];
my $ft = File::Type->new();
my $type = $ft->mime_type($filename);

say "The file contents is $type";
