#!/usr/bin/env perl

use Modern::Perl;

my @words = split ' ', scalar(<>);
chomp(my $sentence = scalar(<>));
say replace_words($sentence, @words);

sub replace_words {
    my($sentence, @words) = @_;
    my @sentence = split ' ', $sentence;
    for (@sentence) {
        $_ = replace_word($_, @words);
    }
    return join ' ', @sentence;
}

sub replace_word {
    my($word, @words) = @_;
    for my $repl (@words) {
        if ($word =~ /^$repl/) {
            return $repl;
        }
    }
    return $word;
}
