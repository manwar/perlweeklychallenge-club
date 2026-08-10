#!/usr/bin/perl
use 5.40.1;
use feature qw/ class /;
use warnings;
no warnings qw / experimental::class /;

class BagHash {
    field %data;

    method add(@items) {
        for my $item (@items) {
            $data{$item}++;
        }
    }

    method keys() {
        return keys %data;
    }

    method valueFor($key) {
        return $data{$key};
    }
}

my ($sentence1, $sentence2) = @ARGV;

my $allWords = BagHash->new;
$allWords->add(split /\s+/, $sentence1);
$allWords->add(split /\s+/, $sentence2);

say q{(},
    (join q{, }, map { "\"$_\"" } grep { $allWords->valueFor($_) == 1 } $allWords->keys),
    q{)};