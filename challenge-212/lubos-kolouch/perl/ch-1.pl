#!/usr/bin/perl
use strict;
use warnings;
use Test::More tests => 2;

sub jump_forward {
    my ($word, $jumps) = @_;
    my @letters = split //, $word;
    my @result;

    for my $i (0 .. $#letters) {
        my $is_upper = $letters[$i] =~ /[A-Z]/ ? 1 : 0;
        my $base = $is_upper ? 65 : 97; # Base ASCII code for upper or lower case
        my $current = ord($letters[$i]) - $base; # Convert to 0-based index
        my $new_index = ($current + $jumps->[$i]) % 26; # Apply jump and mod 26
        push @result, chr($new_index + $base); # Convert back to ASCII character
    }

    return join '', @result;
}

is(jump_forward('Perl', [2, 22, 19, 9]), 'Raku', 'Test case 1');
is(jump_forward('Raku', [24, 4, 7, 17]), 'Perl', 'Test case 2');

