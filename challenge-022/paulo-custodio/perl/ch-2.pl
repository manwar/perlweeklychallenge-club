#!/usr/bin/perl

# Challenge 022
#
# Task #2
# Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm.
# The script should have method to encode/decode algorithm. The wiki page
# explains the compression algorithm very nicely.

use strict;
use warnings;
use 5.030;

{
    package Dict;
    use constant EOM => "#";
    use constant SYMBOLS => 'A'..'Z';
    use Object::Tiny::RW qw( dict symbols );

    sub new {
        my($class) = @_;
        my $self = bless { dict => {}, symbols => [] }, $class;
        for (EOM, SYMBOLS) {
            $self->add($_);
        }
        return $self;
    }

    sub last {
        my($self) = @_;
        return scalar(@{$self->symbols}) - 1;
    }

    sub width {
        my($self) = @_;
        return length(sprintf("%b", $self->last));
    }

    sub next_width {
        my($self) = @_;
        return length(sprintf("%b", $self->last+1));
    }

    sub add {
        my($self, $seq) = @_;
        my $last = $self->last + 1;
        $self->dict->{$seq} = $last;
        $self->symbols->[$last] = $seq;
    }

    sub longest_match {
        my($self, $text) = @_;

        # find longest match
        my $len = 0;
        $len++ while $len < length($text)
                  && exists $self->dict->{substr($text, 0, $len+1)};
        my $w = substr($text, 0, $len);
        $text = substr($text, $len);
        my $code = $self->dict->{$w};
        my $old_width = $self->width;

        # store new prefix in the dictionary
        if ($text ne '') {
            my $next_prefix = $w.substr($text, 0, 1);
            $self->add($next_prefix);
        }

        # return code and new text
        return (sprintf("%0*b", $old_width, $code), $text);
    }
}

sub encode {
    my($text) = @_;
    $text .= Dict->EOM;
    my $encoded = "";
    my $dict = Dict->new();

    while ($text ne '') {
        (my $code, $text) = $dict->longest_match($text);
        $encoded .= $code;
    }

    return $encoded;
}

sub decode {
    my($encoded) = @_;
    my $text = "";
    my $dict = Dict->new();

    while ($encoded ne '') {
        my $code = eval("0b".substr($encoded, 0, $dict->width));
        $encoded = substr($encoded, $dict->width);
        my $seq = $dict->symbols->[$code];
        $text .= $seq;
        if ($encoded ne '') {
            my $next_width = $dict->next_width;
            my $next_code = eval("0b".substr($encoded, 0, $next_width));
            my $next_seq = $dict->symbols->[$next_code];
            $dict->add($seq.substr($next_seq, 0, 1));
        }

    }

    # remove end terminator
    $text = substr($text, 0, length($text)-1);

    return $text;
}


# main
my($op, $arg) = @ARGV;
if ($op =~ /^enc/i) {
    say encode($arg);
}
elsif ($op =~ /^dec/i) {
    say decode($arg);
}
else {
    die "Usage: ch-2.pl encode|decode text\n";
}
