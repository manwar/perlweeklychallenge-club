#!/usr/bin/env perl

use strict;
use warnings;
use utf8::all;
use feature "say";
use experimental "signatures";

sub similar_list( $list1, $list2, @list3 ) {
    # Return false if the list1 and list2 are different length
    if ( $#$list1 != $#$list2 ) {
        return 0;
    }

    # Create mapping hash to map words to their target word
    my %mapping = ();
    foreach my $mapping_list (@list3) {
        my $target_word = pop(@$mapping_list);
        foreach my $word (@$mapping_list) {
            $mapping{$word} = $target_word;
        }
    }

    # Convert the first two list
    my @target_list1 = map { exists $mapping{$_} ? $mapping{$_} : $_ } @$list1;
    my @target_list2 = map { exists $mapping{$_} ? $mapping{$_} : $_ } @$list2;

    # Check for equality
    for my $i ( 0 .. $#$list1 ) {
        if ( $target_list1[$i] ne $target_list2[$i] ) {
            return 0;
        }
    }

    return 1;
}

sub main (@ints) {
    # Convert input into list of words, seperared by commas
    my @list_of_words = ( map{[ split(/,/, $_) ]} @ARGV);
    my $list1 = shift(@list_of_words);
    my $list2 = shift(@list_of_words);
    say similar_list($list1, $list2, @list_of_words) ? 'true' : 'false';
}

main(@ARGV);