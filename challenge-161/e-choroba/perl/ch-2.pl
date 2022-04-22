#!/usr/bin/perl
use warnings;
use strict;
use feature qw{ say };
use Syntax::Construct qw{ // /r };

sub pangrams {
    my ($dictionary) = @_;
    my $pangram = "";
    open my $in, '<', $dictionary or die $!;
    chomp( my @words = <$in> );

    my $missing = join "", 'a' .. 'z';
    while ($missing) {
        my $word = @words[ rand @words ];

        # Only consider words that introduce a new char.
        if ($word =~ /[$missing]/) {
            $pangram .= "$word ";
            $missing =~ s/[$word]//g;
        }
    }
    return $pangram =~ s/ $//r
}

my $dictionary = shift // 'dictionary.txt';
say pangrams($dictionary);
