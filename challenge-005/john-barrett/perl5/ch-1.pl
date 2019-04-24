#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

my $word = sortedlc( $ARGV[0] );
my $wordlength = length $word;

sub sortedlc { join '', sort { $a cmp $b } split '', lc $_[0] }

sub is_anagram {
    my ( $dictword ) = @_;
    return 0 if length $dictword != $wordlength;
    $word eq sortedlc $dictword;
}

open my $fh, '<:encoding(UTF-8)', '/usr/share/dict/words';
chomp( my @dict = <$fh> );
printf "$_\n" for grep { is_anagram( $_ ) } @dict;
