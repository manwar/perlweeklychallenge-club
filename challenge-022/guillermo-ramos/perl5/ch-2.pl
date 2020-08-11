#!/usr/bin/env perl
#
# Write a script to implement Lempel–Ziv–Welch (LZW) compression algorithm. The
# script should have method to encode/decode algorithm. The wiki page explains
# the compression algorithm very nicely.
#
# (https://en.wikipedia.org/wiki/Lempel%E2%80%93Ziv%E2%80%93Welch).
################################################################################

use strict;
use warnings;

################################################################################
# Naïve implementation of a bidirectional map
my $MAX_BIT_WIDTH = 12;
sub bimap_new {
    return {binwidth=>0, sym2bin=>{}, bin2sym=>{}};
}
sub bimap_extend {
    my ($dict, $binwidth) = @_;
    return unless $binwidth > $dict->{binwidth} && $binwidth <= $MAX_BIT_WIDTH;
    my ($sym2bin, $bin2sym) = @$dict{'sym2bin', 'bin2sym'};
    foreach my $sym (keys %$sym2bin) {
        my $bin = $sym2bin->{$sym};
        delete $bin2sym->{$bin};
        $bin = "0" x ($binwidth - length $bin) . $bin;
        $sym2bin->{$sym} = $bin;
        $bin2sym->{$bin} = $sym;
    }
    $dict->{binwidth} = $binwidth;
}
sub bimap_insert {
    my ($dict, $sym) = @_;
    my ($sym2bin, $bin2sym) = @$dict{'sym2bin', 'bin2sym'};
    return $dict->{sym2bin}{$sym} if exists $dict->{sym2bin}{$sym};
    my $ord = keys %{$dict->{sym2bin}}; # Ordinal of symbol to insert in decimal
    my $bin = sprintf "%b", $ord; # ... and in binary (string of 1/0s)
    return unless length $bin <= $MAX_BIT_WIDTH;
    $sym2bin->{$sym} = $bin; # Update symbol -> binary mapping
    $bin2sym->{$bin} = $sym; # Update binary -> symbol mapping

    # Extend with left zeroes the previously inserted binaries
    bimap_extend($dict, length($bin));

    return $bin;
}


################################################################################
# Default dictionary
my $DEFAULT_DICT = bimap_new();
my $STOP = '';
bimap_insert($DEFAULT_DICT, $_) foreach (map(chr, 1..254), $STOP);

sub binary_encode {
    my $text = shift;
    my $binary = pack("B*", $text);
    return $binary;
}

sub binary_decode {
    my $binary = shift;
    my $text = unpack("B*", $binary);
    return $text
}

sub lzw_encode {
    my $dict = shift;
    my $input = shift;
    my ($sym2bin, $bin2sym) = @{$dict}{'sym2bin', 'bin2sym'};

    my $out = '';
    my $w = '';
    foreach my $i (0 .. length($input)-1) {
        my $char = substr($input, $i, 1);
        my $dict_seq = $w . $char;
        unless (exists $sym2bin->{$dict_seq}) {
            $out .= $sym2bin->{$w};
            bimap_insert($dict, $dict_seq);
            $w = '';
        }
        $w .= $char;
    }
    $out .= $sym2bin->{$w} . $sym2bin->{$STOP};
    return binary_encode($out);
}

sub lzw_decode {
    my $dict = shift;
    my $input = binary_decode(shift());
    my ($sym2bin, $bin2sym) = @{$dict}{'sym2bin', 'bin2sym'};

    my $out = '';
    my $lastsym;
    while ($input) {
        my $sym;
        foreach my $bin (keys %$bin2sym) {
            if ($input =~ /^$bin/) {
                $sym = $bin2sym->{$bin};
                $input = substr($input, $dict->{binwidth});
                last;
            }
        }
        unless (defined $sym) {
            $sym = $lastsym . substr($lastsym, 0, 1);
            $input = substr($input, $dict->{binwidth});
        }
        $out .= $sym;
        if ($sym eq $STOP) {
            return $out;
        }
        return $out if $sym eq $STOP;
        if (defined $lastsym) {
            my $bin = bimap_insert($dict, $lastsym . $sym);
            if ((log($dict->{binwidth}) / log(2)) =~ /^\d+$/) {
                bimap_extend($dict, $dict->{binwidth}+1);
            }
        }
        $lastsym = $sym;
    }
}

sub usage {
    die "Usage: $0 -e | --encode | -d | --decode\n";
}
my $mode = shift || usage;
if ($mode eq '-e' || $mode eq '--encode') {
    my $input = join "", <>;
    my $out = lzw_encode($DEFAULT_DICT, $input);
    my $comprate = 100 * length($out) / length($input);
    printf STDERR "Compressed to %.2f%% of original size\n", $comprate;
    print $out;
} elsif ($mode eq '-d' || $mode eq '--decode') {
    my $input = join "", <>;
    my $out = lzw_decode($DEFAULT_DICT, $input);
    print $out;
} else {
    usage;
}
