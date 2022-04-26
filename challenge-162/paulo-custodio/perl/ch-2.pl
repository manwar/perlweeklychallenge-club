#!/usr/bin/env perl

# Challenge 162
#
# Task 2: Wheatstone-Playfair
# Submitted by: Roger Bell_West
# Implement encryption and decryption using the Wheatstone-Playfair cipher.
#
# Examples:
# (These combine I and J, and use X as padding.)
#
# encrypt("playfair example", "hide the gold in the tree stump")
# = "bmodzbxdnabekudmuixmmouvif"
#
# decrypt("perl and raku", "siderwrdulfipaarkcrw") = "thewexeklychallengex"

use Modern::Perl;

{
    package WPcipher;
    use Object::Tiny::RW qw( key letters );

    sub new {
        my($class, $key_phrase) = @_;
        my $self = bless { key => [], letters => {} }, $class;
        $self->make_key($key_phrase);
        return $self;
    }

    sub make_key {
        my($self, $key_phrase) = @_;

        $self->key([[],[],[],[],[]]);
        $self->letters({});

        my $row = 0;
        my $col = 0;
        for my $c (split(//, lc($key_phrase)), 'a' .. 'z') {
            next unless $c =~ /^[a-z]$/;
            $c = 'i' if $c eq 'j';
            next if exists $self->letters->{$c};

            $self->key->[$row][$col] = $c;
            $self->letters->{$c} = [$row, $col];

            $col++;
            if ($col >= 5) {
                $row++;
                $col = 0;
                if ($row >= 5) {
                    last;
                }
            }
        }
    }

    sub peek {
        my($self, $row, $col) = @_;
        return $self->key->[($row+5) % 5][($col+5) % 5];
    }

    sub encrypt_pair {
        my($self, $a, $b, $dir) = @_;

        for ($a, $b) {
            die $_ unless /^[a-ik-z]$/;
        }
        die if $a eq $b;

        my($row1, $col1) = @{$self->letters->{$a}};
        my($row2, $col2) = @{$self->letters->{$b}};

        if ($row1 == $row2) {
            return ($self->peek($row1, $col1+$dir),
                    $self->peek($row2, $col2+$dir));
        }
        elsif ($col1 == $col2) {
            return ($self->peek($row1+$dir, $col1),
                    $self->peek($row2+$dir, $col2));
        }
        else {
            return ($self->peek($row1, $col2),
                    $self->peek($row2, $col1));
        }
    }

    sub encrypt_string {
        my($self, $text, $dir) = @_;
        $text = lc($text);
        my $out = "";
        while ($text ne "") {
            $text .= "x" if length($text)==1;
            my($a, $b);
            if ($text =~ /^(.)\1/) {    # repeated first character
                $a = substr($text, 0, 1);
                $b = "x";
                $text = substr($text, 1);
            }
            else {
                $a = substr($text, 0, 1);
                $b = substr($text, 1, 1);
                $text = substr($text, 2);
            }
            my($x, $y) = $self->encrypt_pair($a, $b, $dir);
            $out .= $x.$y;
        }
        return $out;
    }

    sub encrypt {
        my($self, $text) = @_;
        for ($text) {
            s/[^a-z]//g;
            tr/j/i/;
        }
        return $self->encrypt_string($text, 1);
    }

    sub decrypt {
        my($self, $code) = @_;
        return $self->encrypt_string($code, -1);
    }

}

@ARGV==3 or die "Usage: ch-2.pl -e|-d key text\n";
my($op, $key_phrase, $text) = @ARGV;

my $wp = WPcipher->new($key_phrase);
if ($op eq "-e") {
    say $wp->encrypt($text);
}
elsif ($op eq "-d") {
    say $wp->decrypt($text);
}
else {
    die "Usage: ch-2.pl -e|-d key text\n";
}
