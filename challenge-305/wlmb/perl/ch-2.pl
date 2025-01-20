#!/usr/bin/env perl
# Perl weekly challenge 305
# Task 2:  Alien Dictionary
#
# See https://wlmb.github.io/2025/01/20/PWC305/#task-2-alien-dictionary
use v5.36;
die <<~"FIN" unless @ARGV;
    Usage: $0 D W1 W2...
    to sort the words Wi according the the order of
    letters in the dictionary D. The dictionary is
    a string with all letters.
    FIN
my %values;
my $i=0;
$values{lc $_}=$i++ for split "", my $dictionary=shift;
die "Non-ascii letters: $dictionary" unless $dictionary =~ /^[a-z]*$/i;
my @letters=("A".."Z");
die "Missing letters: $dictionary" unless keys %values==@letters;
die "Repeated letters: $dictionary" unless length $dictionary == @letters;

my @sorted= map {$_->[0]}
    sort {compare($a->[1], $b->[1])}
    map {[$_, [split "", $_]]} @ARGV;
say "$dictionary; @ARGV -> @sorted";

sub compare($x, $y){
    my @x=@$x;
    my @y=@$y;
    return 0 unless @x||@y; #
    return -1 unless @y;
    return 1 unless @x;
    my $cmp = $values{shift @x}<=>$values{shift @y};
    return $cmp || compare(\@x,\@y);
}
