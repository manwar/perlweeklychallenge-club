#!/usr/bin/env perl
# Perl weekly challenge 131
# Task 2: Find pairs
#
# See https://wlmb.github.io/2021/09/21/PWC131/#task-1-find-pairs
use v5.12;
use warnings;
my ($delims, $string)=@ARGV;
my @delims=split '', $delims;
die "Unbalanced delims $delims" unless @delims%2==0; # need even number
my (%open_delim, %close_delim);
map {$open_delim{$delims[2*$_]}=1;
     $close_delim{$delims[2*$_+1]}=1} 0..@delims/2-1;
my (@open,  @close);
map {push @open, $_ if $open_delim{$_};
     push @close, $_ if $close_delim{$_};} split '', $string;
say "Input:\n\tDelimiter pairs: $delims\n",
    "\tSearch string: $string\nOutput:\n\t",
     @open, "\n\t", @close; # avoid interpolated spaces
