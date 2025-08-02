#!/usr/bin/perl
use 5.038;
use warnings;

sub pick(@array) {
    return $array[int(rand(@array))];
}

sub newChar($left, $right) {
    my $replacement = $left;

    while ($replacement eq $left || $replacement eq $right) {
        $replacement = pick('a' .. 'z');
    }

    return "$left$replacement$right";
}

$_ = shift; s/(.) \? (.)/newChar($1, $2)/egx; say;