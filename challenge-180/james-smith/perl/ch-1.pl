#!/usr/local/bin/perl

use strict;

use warnings;
use feature qw(say);
use Test::More;
use List::MoreUtils qw(firstidx frequency);

my @TESTS = (
  [ 'Perl Weekly Challenge',  0 ],
  [ 'Long Live Perl',         1 ],
  [ 'P.O.O.P',               -1 ],
  [ 'tractors',               2 ],
  [ 'aabbccddeeffg',         12 ],
  [ 'taumatawhakatangihangakoauauotamateaturipukakapikimaungahoronukupokaiwhenuakitanatahu',-1 ],
  [ 'LLANFAIRPWLLGWYNGYLLGOGERYCHWYRNDROBWLLLLANTYSILIOGOGOGOCH', 4 ],
  [ 'Krung Thep Mahanakhon Amon Rattanakosin Mahinthara Ayuthaya Mahadilok Phop Noppharat Ratchathani Burirom Udomratchaniwet Mahasathan Amon Piman Awatan Sathit Sakkathattiya Witsanukam Prasit', 0 ],
  [ 'krung thep mahanakhon amon rattanakosin mahinthara ayuthaya mahadilok phop noppharat ratchathani burirom udomratchaniwet mahasathan amon piman awatan sathit sakkathattiya witsanukam prasit', 4 ],
);

is( first_unique($_->[0]), $_->[1] ) foreach @TESTS;
is( u($_->[0]),            $_->[1] ) foreach @TESTS;

done_testing();

sub first_unique {
  my %counts = frequency my @p = split //, pop;
  firstidx { $counts{$_} < 2 } @p;
}

sub u{my%c;$c{$_}++for@_=split//,pop;firstidx{$c{$_}<2}@_}
