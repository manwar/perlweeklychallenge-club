#!/usr/bin/perl
use 5.40.1;
use warnings;

my @arr = @ARGV;

my %reflectiona;
for my $e (@arr) {
    push @{ $reflections{ oct('0b' . reverse sprintf('%b', $e)) } }, $e;
}

my @sorted;
for my $k ( sort { $a <=> $b } keys %reflections ) {
    push @sorted, ( sort { $a <=> $b } @{ $reflections{$k} } );
}

say q{(}, (join q{, }, @sorted), q{)};
