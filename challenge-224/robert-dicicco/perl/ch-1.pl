#!/usr/bin/env perl
=begin comment
----------------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-03
Challenge 224 Task 1 Special Notes ( Perl )
----------------------------------------------
=cut
use strict;
use warnings;
use feature 'say';


my $source = $ARGV[0];
my $target = $ARGV[1];
my $flag = 0;
my $offset = 0;

while ($offset < length($target)) {
    my $letter = substr($target, $offset, 1);
    if ($source !~ /$letter/) {
      say "Output: false";
      $flag = -1;
      last;
    }
    $offset++;
}

if ($flag == 0) {
    say "Output: true";
}

=begin comment
----------------------------------------------
perl .\SpecialNotes.pl abc xyz
Output: false

perl .\SpecialNotes.pl scriptinglanguage perl
Output: true

perl .\SpecialNotes.pl aabbcc abc
Output: true

=cut


