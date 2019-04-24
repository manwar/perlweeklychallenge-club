#!/usr/bin/env perl

use strict;
use warnings;
use autodie;

my $word = join '', sort { $a cmp $b } split '', lc $ARGV[0];
my $wordlength = length $word;

sub is_anagram {
    my ( $dictword ) = @_;
    return 0 if length $dictword != $wordlength;
    $word eq join '', sort { $a cmp $b } split '', lc $dictword;
}

open my $fh, '<:encoding(UTF-8)', '/usr/share/dict/words';
chomp( my @dict = <$fh> );
printf "$_\n" for grep { is_anagram( $_ ) } @dict;
