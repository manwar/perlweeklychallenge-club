#! /usr/bin/perl

use strict;
use warnings;
use experimental 'signatures';

use Test::More tests => 5;

is(validtokencounter('cat and dog'), 3, 'example 1');
is(validtokencounter('a-b c! d,e'), 2, 'example 2');
is(validtokencounter('hello-world! this is fun'), 4, 'example 3');
is(validtokencounter('ab- cd-ef gh- ij!'), 2, 'example 4');
is(validtokencounter('wow! a-b-c nice.'), 2, 'example 5');

sub validtokencounter($a) {
  my $count = 0;
  foreach my $k (split ' ', $a) {
    # "contains no digits"
    if ($k =~ /[0-9]/) {
      next;
    }
    # "has at most one hyphen surrounded by lowercase letters"
    # multiple hyphens
    if ($k =~ /-.*-/) {
      next;
    }
    # if hyphen, must be surrounded by letters
    if ($k =~ /-/ &&
        $k !~ /[a-z]-[a-z]/) {
      next;
    }
    # "at most one punctuation mark (!, ., ,) appearing only at the end."
    if ($k =~ /[.,!]./) {
      next;
    }
    $count += 1;
  }
  $count;
}
