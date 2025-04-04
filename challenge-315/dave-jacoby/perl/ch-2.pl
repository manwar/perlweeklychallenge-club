#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

my @examples = (
    {
        sentence =>
            "Perl is a my favourite language but Python is my favourite too.",
        first  => "my",
        second => "favourite",
    },
    {
        sentence =>
            "Barbie is a beautiful doll also also a beautiful princess.",
        first  => "a",
        second => "beautiful",
    },
    {
        sentence => "we will we will rock you rock you.",
        first    => "we",
        second   => "will",
    }
);

for my $example (@examples) {
    my @output = find_third($example);
    my $output = join ', ', map { qq{"$_"} } @output;
    my ( $first, $second, $sentence ) =
        map { $example->{$_} } qw{ first second sentence };
    say <<"END";
    Input:  \$sentence = "$sentence"
            \$first = "$first"
            \$second = "$second"
    Output: ($output)
END
}

sub find_third ($obj) {
    my @output;
    my ( $first, $second, $sentence ) =
        map { $obj->{$_} } qw{ first second sentence };
    my @sentence = split /\W+/, $sentence;
    for my $i ( 0 .. $#sentence ) {
        if (   $sentence[$i] eq $first
            && $sentence[ $i + 1 ] eq $second
            && defined $sentence[ $i + 2 ] )
        {
            push @output, $sentence[ $i + 2 ];
        }
    }
    return @output;
}
