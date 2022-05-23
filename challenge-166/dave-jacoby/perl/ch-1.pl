#!/usr/bin/env perl

use strict;
use warnings;
use experimental qw{ say postderef signatures state };

use Carp;
use List::Compare;
use List::Util qw{ first };

my @words   = get_words();
my @letters = qw{ a b c d e f o l i s t };
my @banned  = bad_letters(@letters);
my %banned  = map { $_ => 1 } @banned;
my %mapping = (
    i => '1',
    l => '1',
    o => '0',
    s => '5',
    t => '7',
);
map { $mapping{$_} = $_ } 'a' .. 'f';

# @words = qw{ silo solo soda odd };

OUTER: for my $word ( sort { length $a <=> length $b } @words ) {
    my $hax0r;
    for my $l ( split //, $word ) {
        my $m = $mapping{$l};
        $hax0r .= defined $m ? $m : $l;
        next OUTER if $banned{$l};
    }
    say qq{ +  $word\n\t0x$hax0r };
}

sub get_words {
    my $dictionary = './dictionary.txt';
    if ( -f $dictionary && open my $fh, '<', $dictionary ) {
        my @words =
            grep { length $_ < 9 && length $_ > 1 }
            map { chomp; lc $_ } <$fh>;
        return @words;
    }
    croak 'No dictioary file';
}

sub bad_letters( @letters ) {
    my @alpha  = 'a' .. 'z';
    my $lc     = List::Compare->new( \@letters, \@alpha );
    my @banned = $lc->get_complement();
    return @banned;
}
