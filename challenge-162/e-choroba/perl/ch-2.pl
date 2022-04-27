#!/usr/bin/perl
use warnings;
use strict;

{   package Wheatstone::Playfair;
    use Moo;

    has alphabet => (is => 'lazy');

    sub encrypt {
        my ($self, $passphrase, $message) = @_;
        $self->_crypt($passphrase, $message, 1);
    }

    sub decrypt {
        my ($self, $passphrase, $message) = @_;
        $self->_crypt($passphrase, $message, -1);
    }

    sub _crypt {
        my ($self, $passphrase, $message, $step) = @_;

        tr/A-Z/a-z/, s/[^a-z]//g, s/j/i/g for $passphrase, $message;

        my %seen;
        my $table_string = "";
        for my $char (split //, $passphrase . $self->alphabet) {
            unless ($seen{$char}++) {
                $table_string .= $char;
            }
        }

        my %table;
        for my $y (0 .. 4) {
            for my $x (0 .. 4) {
                my $char = substr $table_string, 0, 1, "";
                $table{$char} = [$x, $y];
                $table{$x}{$y} = $char;
            }
        }

        1 while $message =~ s/^(?:..)*?\K(.)\1/$1x$1/;
        $message .= 'x' if length($message) % 2;
        my $out = "";
        while (length $message) {
            $message =~ s/^(.)(.{1}+)//;
            my ($ch1, $ch2) = ($1, $2);
            my ($x1, $y1) = @{ $table{$ch1} };
            my ($x2, $y2) = @{ $table{$ch2} };
            my ($ch1_out, $ch2_out);

            if ($x1 != $x2 && $y1 != $y2) {
                ($x1, $x2) = ($x2, $x1);
            } elsif ($x1 == $x2) {
                $_ = ($_ + $step) % 5 for $y1, $y2;
            } else {
                $_ = ($_ + $step) % 5 for $x1, $x2;
            }

            $ch1_out = $table{$x1}{$y1};
            $ch2_out = $table{$x2}{$y2};
            $out .= "$ch1_out$ch2_out";
        }
        return $out
    }

    sub _build_alphabet {
        join "", grep $_ ne 'j', 'a' .. 'z'
    }
}

use Test::More tests => 4;
my $wp = 'Wheatstone::Playfair'->new;

is $wp->encrypt('playfair example', 'hide the gold in the tree stump'),
    'bmodzbxdnabekudmuixmmouvif',
    'Example 1';

is $wp->decrypt('perl and raku', 'siderwrdulfipaarkcrw'),
    'thewexeklychallengex',
    'Example 2';

is $wp->decrypt(
        'playfair example',
        $wp->encrypt('playfair example', 'hide the gold in the tree stump')
    ),
    'hidethegoldinthetrexestump',
    'Roundtrip 1';

is $wp->encrypt(
        'perl and raku',
        $wp->decrypt('perl and raku', 'siderwrdulfipaarkcrw'),
    ),
    'siderwrdulfipaarkcrw',
    'Roundtrip 2';
