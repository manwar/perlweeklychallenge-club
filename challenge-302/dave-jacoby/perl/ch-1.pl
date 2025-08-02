#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say state postderef signatures };

use Algorithm::Permute;

my @examples = (

    {
        x   => 5,
        y   => 3,
        str => [ "10", "0001", "111001", "1", "0" ],
    },
    {
        x   => 1,
        y   => 1,
        str => [ "10", "1", "0" ],
    },
);

for my $example (@examples) {
    my $x      = $example->{x};
    my $y      = $example->{y};
    my $str    = join ', ', map { qq{"$_"} } $example->{str}->@*;
    my $output = ones_and_zeros($example);
    say <<"END";
    Input:  \@str = ($str)
            \$x = $x
            \$y = $y
    Output: $output
END
}

sub ones_and_zeros($example) {
    my $x   = $example->{x};
    my $y   = $example->{y};
    my @str = $example->{str}->@*;
    my $l   = scalar @str;
    my @output;
    for my $n ( reverse 1 .. $l ) {
        my @str = $example->{str}->@*;
        my $p   = Algorithm::Permute->new( \@str, $n );
        while ( my @p = $p->next() ) {
            my $pp = join ' ', @p;
            my $z  = () = $pp =~ /0/g;
            my $o  = () = $pp =~ /1/g;
            push @output, scalar @p if $y == $o && $x == $z;
        }
    }
    return ( sort { $b <=> $a } @output)[0];
}
