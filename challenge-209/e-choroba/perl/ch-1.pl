#! /usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub special_bit_characters(@bits) {
    my $pos = $#bits - 1;
    --$pos while 1 == $bits[$pos];
    return ($#bits - $pos) % 2
}

sub special_bit_characters_slow(@bits) {
    my $string = "";
    for (my $pos = 0; $pos <= $#bits; ++$pos) {
        if ($bits[$pos] eq 0) {
            $string .= 'a';
        } else {
            $string .= $bits[++$pos] ? 'c' : 'b';
        }
    }
    return ('a' eq substr $string, -1) ? 1 : 0
}

my %TO_BITS = (a => [0],
               b => [1, 0],
               c => [1, 1]);
sub encode($string) {
    return map @{ $TO_BITS{$_} }, split //, $string
}

use Test::More tests => 2 + 72;
is special_bit_characters_slow(1, 0, 0), 1, 'Example 1';
is special_bit_characters_slow(1, 1, 1, 0), 0, 'Example 2';

my @strings = qw( a b aa ab ba bb ca cb
                  aaa aab aba abb aca acb
                  baa bab bba bbb bca bcb
                  caa cab cba cbb cca ccb );
push @strings, map $_ . qw( a b )[int rand 2],
               join "",
               map qw( a b c )[int rand 3],
               1 .. 100
    for 1 .. 10;

for my $string (@strings) {
    my @bits = encode($string);
    is special_bit_characters_slow(@bits),
        ($string =~ /a$/) ? 1 : 0,
        "$string";
    is special_bit_characters(@bits),
       special_bit_characters_slow(@bits),
       "same $string";
}

use Benchmark qw{ cmpthese };

my @inputs = map [encode($_)], @strings;
cmpthese(-3, {
    slow => sub { special_bit_characters_slow(@$_) for @inputs },
    fast => sub { special_bit_characters(@$_) for @inputs }
});

__END__
        Rate slow fast
slow  5103/s   -- -82%
fast 27748/s 444%   --
