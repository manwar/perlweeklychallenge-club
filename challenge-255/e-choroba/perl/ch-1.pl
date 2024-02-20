#!/usr/bin/perl
use warnings;
use strict;
use experimental qw( signatures );

sub odd_character_loop($s, $t) {
    my @s = ((sort split //, $s), "");
    my @t = sort split //, $t;
    for my $i (0 .. $#t) {
        return $t[$i] if $s[$i] ne $t[$i];
    }
}

sub odd_character_hash($s, $t) {
    my %char;
    ++$char{$_} for split //, $t;
    --$char{$_} for split //, $s;
    return (grep $char{$_}, keys %char)[0]
}

use Test::More tests => 2 * (3 + 1);

my $s = q(Perl officially stands for Practical Extraction and Report
Language, except when it doesn't.

Perl was originally a language optimized for scanning arbitrary text
files, extracting information from those text files, and printing
reports based on that information. It quickly became a good language
for many system management tasks. Over the years, Perl has grown into
a general-purpose programming language. It's widely used for
everything from quick "one-liners" to full-scale application
development.);

my $t = $s;
substr $t, 100, 0, '!';

for my $odd_character (\&odd_character_loop, \&odd_character_hash) {
    is $odd_character->('Perl', 'Preel'),     'e', 'Example 1';
    is $odd_character->('Weekly', 'Weeakly'), 'a', 'Example 2';
    is $odd_character->('Box', 'Boxy'),       'y', 'Example 3';
    is $odd_character->($s, $t),              '!', 'Long';
}

use Benchmark qw{ cmpthese };
cmpthese(-3, {
    loop => sub { odd_character_loop($s, $t) },
    hash => sub { odd_character_hash($s, $t) },
});

__END__
       Rate loop hash
loop 4057/s   -- -56%
hash 9133/s 125%   --
