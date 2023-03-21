#!/usr/bin/perl

use strict;
use warnings;
use Test::More;

sub decode_bits {
    my ($bits) = @_;

    # Decode the binary bits and store the characters in @decoded array
    my @decoded;
    my $i = 0;
    while ($i < scalar @$bits) {
        if ($bits->[$i] == 0) {
            push @decoded, 'a';
            $i++;
        } elsif ($bits->[$i] == 1 && $bits->[$i+1] == 0) {
            push @decoded, 'b';
            $i += 2;
        } elsif ($bits->[$i] == 1 && $bits->[$i+1] == 1) {
            push @decoded, 'c';
            $i += 2;
        }
    }

    return \@decoded;
}

# Test case 1
my $bits1 = [1, 0, 0];
my $decoded1 = decode_bits($bits1);
is($decoded1->[-1], 'a', 'Test case 1 - last character is "a"');

# Test case 2
my $bits2 = [1, 1, 1, 0];
my $decoded2 = decode_bits($bits2);
ok($decoded2->[-1] eq 'a' ? 0 : 1, 'Test case 2 - last character is "a" or not');

done_testing();

