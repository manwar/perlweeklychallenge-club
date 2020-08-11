#!/usr/bin/env perl

##########################
#  Challenge 032, part 2 #
##########################

use strict;
use warnings;
use v5.10;

my $encoding = ':encoding(UTF-8)';
binmode STDOUT, $encoding;

my $data = { 
    lenovo => 5,
    acer => 4, 
    xiaomi => 6, 
    opticom => 1, 
    tatysh_corp => 10 
};
generate_bar_graph($data);

sub generate_bar_graph {
    my $info = shift;
    my $line_pos = calc_line_pos($info);
    for my $word (sort {$info->{$b} <=> $info->{$a}} keys %$info) {
        my $spaces = calc_start_spaces($word, $line_pos);
        my $bars = calc_bars($info->{$word});
        say $spaces.$word.' | '.$bars;
    }
}

sub calc_line_pos {
    my $info = shift;
    my $max_length = 0;
    foreach my $word (keys %$info) {
        my $w_length = length $word;
        $max_length = $w_length if $max_length < $w_length;
    }
    return $max_length++;
}

sub calc_start_spaces {
    my ($word, $line_pos) = @_;
    my $w_length = length $word;
    my $n_spaces =  $line_pos - $w_length;
    my $spaces = '';
    for (1 .. $n_spaces) {$spaces .=' '}
    return $spaces;
}

sub calc_bars {
    my $val = shift;
    my $result = '';
    for (1 .. $val) {$result.='###'}
    return $result;
}
