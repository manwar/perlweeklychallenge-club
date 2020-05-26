#!/usr/bin/env perl6

use v6.d;

sub MAIN(Str :$file, Bool :$unique?) {

    my $sorted = sort-data($file, $unique);
    say $sorted.join("\n");
}

sub sort-data(Str $file, Bool $unique?) {

    my $io := $file.IO;
    die "ERROR: '$file' not found"    unless $io.e;
    die "ERROR: '$file' not readable" unless $io.r;

    my @source = ();
    my %source = ();
    for $io.lines -> Str $line {
        my ($mailbox, $domain) = $line.split("@");
        push @source, [$mailbox, $domain];
        if $unique {
            %source.{$mailbox} = $domain;
        }
    }

    my $sorted = [];
    if $unique {
        for %source.sort({ $^a.value.lc cmp $^b.value.lc || $^a.key cmp $^b.key }) -> $k {
            my $_k = $k.keys;
            my $_v = $k.values;
            $sorted.push: ($_k, $_v).join("@");
        }
    }
    else {
        for @source.sort({ $^a.[0].lc cmp $^b.[0].lc || $^a.[1] cmp $^b.[1] }).reverse -> $k {
            $sorted.push: $k.join("@");
        }
    }

    return $sorted;
}
