#!/usr/bin/perl
use strict;
use warnings;
use feature qw /say/;

my %dispatch;

sub function_builder {
    my $letter = shift;
    my $file_name = "${letter}_letter.txt";
    open my $FH, ">", $file_name or die "Could not open $file_name $!";
    return sub { say $FH shift }
}

while (<>) {
    chomp;
    for my $word (split / /, lc $_) {
        my $letter = substr $word, 0, 1;
        next if $letter !~ /^[a-z]/;
        $dispatch{$letter} = function_builder($letter) unless defined $dispatch{$letter};
        $dispatch{$letter}->($word);
    }
}
