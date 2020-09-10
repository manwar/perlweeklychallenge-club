# vim:set ts=4 sw=4 sts=4 et ai wm=0 nu:
#
#===============================================================================
# FILE: WordSearch.t
# DESCRIPTION: Unit test for WordSearch
#===============================================================================

use strict;
use warnings;
use v5.30;

use Test2::V0;

use WordSearch;

my $ws = WordSearch->new();
isa_ok($ws, "WordSearch");

$ws->loadWordlist("t/wordlist.txt", 5);
is( scalar(@{$ws->{_wordlist}}), 54, "loadWordlist size");
is($ws->{_wordlist}->[0], "aimed",   "loadWordlist first word");
is($ws->{_wordlist}->[53], "wigged", "loadWordlist last word");

$ws->loadGrid("t/searchgrid.txt");
my $g = $ws->{_grid};
is ( scalar(@$g), 19,                "loadGrid rows");
is ( scalar(@{$g->[0]}), 16,         "loadGrid cols");

done_testing();
