#!/usr/bin/perl
use warnings;
use strict;

{   package Chaocipher;
    use Moo;

    has [qw[ pt ct ]]        => (is => 'ro');
    has [qw[ _pt _ct _pos ]] => (is => 'rw');

    sub BUILD { shift->rewind }

    sub rewind {
        my ($self) = @_;
        $self->_ct($self->ct);
        $self->_pt($self->pt);
    }

    sub _get_cipher_letter {
        my ($self, $letter) = @_;
        $self->_pos(index $self->_pt, $letter);
        return substr $self->_ct, $self->_pos, 1
    }

    sub _get_plain_letter {
        my ($self, $letter) = @_;
        $self->_pos(index $self->_ct, $letter);
        return substr $self->_pt, $self->_pos, 1
    }

    sub _rotate {
        my ($self, $is_cipher) = @_;
        my $cp = $self->${\ qw(_pt _ct)[$is_cipher] };
        $cp .= substr $cp, 0, $self->_pos, "";
        $cp .= substr $cp, 0, 1, "" unless $is_cipher;
        substr $cp, 13, 0, substr $cp, 2 - $is_cipher, 1, "";
        return $cp
    }

    sub encode {
        my ($self, $text, $is_plain) = @_;
        $is_plain ||= 0;
        my $cipher_text = "";
        for my $i (0 .. length($text) - 1) {
            my $letter = substr $text, $i, 1;
            $cipher_text .= $self->${\
                qw( _get_cipher_letter _get_plain_letter )[$is_plain]
            }($letter);
            $self->_ct($self->_rotate(1));
            $self->_pt($self->_rotate(0));
        }
        $self->rewind;
        return $cipher_text
    }

    sub decode {
        my ($self, $text) = @_;
        return $self->encode($text, 1)
    }

}

my $ch = 'Chaocipher'->new(
    pt => 'PTLNBQDEOYSFAVZKGJRIHWXUMC',
    ct => 'HXUCZVAMDSLKPEFJRIGTWOBNYQ',
);

use Test::More tests => 4;

is $ch->encode('A'), 'P', 'single letter encoded';
is $ch->encode('WELLDONEISBETTERTHANWELLSAID'),
               'OAHQHCNYNXTSZJRRHJBYHQKSOUJY',
    'long text encoded';

is $ch->decode('P'), 'A', 'single letter decoded';
is $ch->decode('OAHQHCNYNXTSZJRRHJBYHQKSOUJY'),
               'WELLDONEISBETTERTHANWELLSAID',
    'long text decoded';
