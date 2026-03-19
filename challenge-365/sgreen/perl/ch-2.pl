#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub main ($input_string) {
    my $count = grep { /^[a-z]+(\-[a-z]+)?[!,\.]?$/ } split /\s+/,
      $input_string;
    say $count;
}

main(@ARGV);
