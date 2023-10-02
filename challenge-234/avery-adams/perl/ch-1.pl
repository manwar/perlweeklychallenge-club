#!/usr/bin/perl
use v5.36;

my @words;
my %result_chars;

for(@ARGV) {
    push(@words, [split(//, $_)])
}
@words = sort {$#{$a} <=> $#{$b}} @words;
$result_chars{$_}++ for @{$words[0]};

for my $word (1..$#words) {
    for my $key (keys(%result_chars)) {
        my $occurrences = grep(/$key/, @{$words[$word]});
        if($occurrences == 0) {
            delete($result_chars{$key});
            next;
        } elsif($occurrences <= $result_chars{$key}) {
            $result_chars{$key} = $occurrences;
        }
    }
}

for my $char (@{$words[0]}) {
    if($result_chars{$char}) {
        $result_chars{$char}--;
        say $char;
    }
}
