#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ fc say postderef signatures state };

my @examples = (

    {
        str  => 'aBc 11c',
        strs => [ 'accbbb', 'abc', 'abbc' ]
    },
    {
        str  => 'Da2 abc',
        strs => [ 'abcm', 'baacd', 'abaadc' ]
    },
    {
        str  => 'JB 007',
        strs => [ 'jj', 'bb', 'bjb' ]
    },
    {
        str  => 'ABABC',
        strs => [ 'ACAB', 'abcbac', 'bcbaa', 'CAbaB', 'abacab' ]
    },
);

for my $example (@examples) {
    my $output = completing_word($example);
    my $str    = $example->{str};
    my $strs   = join ', ', map { qq{'$_'} } $example->{strs}->@*;

    say <<"END";
    Input: \$str = '$str'
           \@str = ($strs)
    Output: '$output'
END
}

sub completing_word ($obj) {
    my @output;
    my $str  = $obj->{str};
    my @str  = $obj->{strs}->@*;
    my %base = str_disassemble($str);
OUTER: for my $sub (@str) {
        my %sub  = str_disassemble($sub);
        my %keys = map { $_ => 1 } keys %base;
        for my $k ( sort keys %keys ) {
            my $b = $base{$k} || 0;
            my $s = $sub{$k}  || 0;
            next OUTER unless $s >= $b;
        }
        push @output, $sub;
    }
    @output =
        sort { length $a <=> length $b } sort { fc $a cmp fc $b } @output;
    return shift @output;
}

sub str_disassemble ($str) {
    my %base;
    map { $base{$_}++ }
        map { lc $_ } grep { /[A-Za-z]/ } split //, $str;
    return %base;

}
