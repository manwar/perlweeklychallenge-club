#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (

    {
        words => [ "perl", "python", "raku" ],
        alien => [qw/h l a b y d e f g i r k m n o p q j s t u v w x c z/]
    },
    {
        words => [ "the", "weekly", "challenge" ],
        alien => [qw/c o r l d a b t e f g h i j k m n p q s w u v x y z/]
    },
);

for my $example (@examples) {
    my $words  = join ', ', map { qq{"$_"} } $example->{words}->@*;
    my $alien  = join ' ',  $example->{alien}->@*;
    my @output = alien_dictionary($example);
    my $output = join ', ', @output;
    say <<"END";
Input:  \@words = ($words)
        \@alien = qw/$alien/
Output: $output
END
}

sub alien_dictionary ($object) {
    my @words    = $object->{words}->@*;
    my @alien    = $object->{alien}->@*;
    my @alphabet = 'a' .. 'z';
    my %hash;
    for my $i ( 0 .. $#alphabet ) { $hash{ $alien[$i] } = $alphabet[$i]; }
    my @newwords = map { $_->[1] } sort { $a->[0] cmp $b->[0] } map {
        my $new = join '', map { $hash{$_} } split '', $_;
        [ $new, $_ ]
    } @words;
    return @newwords;
}

sub alien ( $word, $hash ) {
    return join '', map { $hash->{$_} } split '', $word;
}