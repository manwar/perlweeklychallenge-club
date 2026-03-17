#!/usr/bin/env perl

# Perl Weekly Challenge 364 - Task 1 - solution by Paulo Custodio
# https://theweeklychallenge.org/blog/perl-weekly-challenge-364/

use Modern::Perl;

my $encode;
if (@ARGV && $ARGV[0] eq "-e") {
    shift;
    $encode = 1;
}

@ARGV or die "usage: $0 [-e] words...\n";
if ($encode) {
    say join(" ", encode(@ARGV));
}
else {
    say join(" ", decode(@ARGV));
}

sub letter_ord {
    my($c) = @_;
    return ord($c) - ord('a') + 1;
}

sub letter_chr {
    my($c) = @_;
    return chr($c + ord('a') - 1);
}

sub encode {
    my(@words) = @_;
    for (@words) {
        $_ = lc($_);
        s/[^a-z]//g;
        s/(.)/ letter_ord($1) < 10 ? letter_ord($1) : letter_ord($1)."#" /ge;
    }
    return @words;
}

sub decode {
    my(@words) = @_;
    for (@words) {
        $_ = lc($_);
        s/[^0-9#]//g;
        s/(\d\d)#/ letter_chr($1) /ge;
        s/(\d)/ letter_chr($1) /ge;
    }
    return @words;
}
