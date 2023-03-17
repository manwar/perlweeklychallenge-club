#!/usr/bin/perl
use strict;
use warnings;

sub lzw_encode {
    my ($data) = @_;
    my %dictionary = map { chr($_) => $_ } (0..255);

    my $current_string = "";
    my @encoded_data;

    foreach my $char (split //, $data) {
        my $combined_string = $current_string . $char;
        if (exists $dictionary{$combined_string}) {
            $current_string = $combined_string;
        } else {
            push @encoded_data, $dictionary{$current_string};
            $dictionary{$combined_string} = scalar keys %dictionary;
            $current_string = $char;
        }
    }

    push @encoded_data, $dictionary{$current_string} if $current_string ne "";
    return \@encoded_data;
}

sub lzw_decode {
    my ($encoded_data) = @_;
    my %dictionary = map { $_ => chr($_) } (0..255);

    my $current_string = chr($encoded_data->[0]);
    my @decoded_data = ($current_string);

    for my $code (@{$encoded_data}[1..$#$encoded_data]) {
        my $entry;
        if (exists $dictionary{$code}) {
            $entry = $dictionary{$code};
        } elsif ($code == scalar keys %dictionary) {
            $entry = $current_string . substr($current_string, 0, 1);
        } else {
            die "Invalid code: $code";
        }

        push @decoded_data, $entry;

        $dictionary{scalar keys %dictionary} = $current_string . substr($entry, 0, 1);
        $current_string = $entry;
    }

    return join("", @decoded_data);
}

my $input_data = "ABABABABABABABAB";
my $compressed_data = lzw_encode($input_data);
print "Compressed data: @{$compressed_data}\n";

my $decompressed_data = lzw_decode($compressed_data);
print "Decompressed data: $decompressed_data\n";

