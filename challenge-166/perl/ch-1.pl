#!/usr/bin/perl
# The Weekly Challenge 166
# Task 1 Hexadecimal Words
# Usage: $ ch-1.pl "word wanna transformed" [DD] [DH] [DN]

use v5.26.0;
use warnings;

my @w;
my @input_par = @ARGV;
my %op;
my $special = shift @input_par;
$op{$_} = 1 for @input_par;

say  'Usage: $ ch-1.pl "word wanna transformed" [DD] [DH] [DN]'
    ."\n"
    .'can go with parameter xi xl xo xs xt'
    ."\n\n"
    .'Test Recommendation: $ ch-1.pl "" DD > test_words'
    if scalar @ARGV == 0;

word_transform() if ($special);
display_dict() if defined $op{"DD"};
display_hex() if defined $op{"DH"};
display_num() if defined $op{"DN"};



sub word_transform {
    say "Transformed word/character:";
    say my $h = transform($special);
    say "Value in decimal: ", hex $h;
    say "";
}

sub display_dict {
    say "Dictionary text:";
    my @words = input();
    @words = filter(@words);
    say join "\n", sort {$a cmp $b} @words;
    say "";
}

sub display_hex {
    say "Transformed Dictionary Words :";
    my @words = input();
    @words = filter(@words);
    say join "\n", map {transform($_)} sort {$a cmp $b} @words;
    say "";
}

sub display_num {
    say "Numbers (sorted):";
    my @words = input();
    @words = filter(@words);
    say join "\n", map {sprintf "%10d", $_ } 
                   sort {$a <=>$b} map {hex transform($_)} @words;
    say "";
}


sub input {
    open FH, "<". "../../data/dictionary.txt"
        or die "Dictionary IS NOT FOUND.";
    while (<FH>) {
        chomp;
        push @w, $_ if /^[abcdefolist]+$/ && length $_ <= 8;
    }
    close FH;
    return @w;
}



sub filter {
    my @words = @_;
    my %word_hash;
    for (@words) {
        $word_hash{$_} = 1
    }
    if (scalar @input_par > 0) {
        for (@words) {
            delete $word_hash{$_} if 
                   (/o/ && defined $op{'xo'})
                || (/l/ && defined $op{'xl'})
                || (/i/ && defined $op{'xi'})
                || (/s/ && defined $op{'xs'})
                || (/t/ && defined $op{'xt'})
                || ( (/li/ || /il/)  && defined $op{'x11'})
        }
    }
    return keys %word_hash;
}



sub transform {
    $_ = $_[0];
    die "Not transformable!" unless /^[abcdefolist]+$/ && length $_ <= 8;
    tr/olist/01157/;
    return "0x". "0" x (8 - length $_) . $_;
}
