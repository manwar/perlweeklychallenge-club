#!/usr/bin/env perl
use v5.38;
use warnings;
use feature 'signatures';
no warnings 'experimental::signatures';

=pod

=head1 NAME

ch-2.pl - Word Sorter

=head1 SYNOPSIS

  perl ch-2.pl                      # runs the embedded tests
  perl ch-2.pl "The quick brown fox"

=head1 DESCRIPTION

Given a sentence, order its words alphabetically (case-insensitive) while
keeping the words themselves unchanged. Output uses single spaces.

=cut

sub word_sorter ($sentence) {
    my @words = grep { length($_) } split /\s+/, $sentence;
    my @sorted = sort { lc($a) cmp lc($b) } @words;
    return join ' ', @sorted;
}

sub _run_tests {
    require Test::More;
    Test::More->import;

    Test::More::is( word_sorter('The quick brown fox'), 'brown fox quick The', 'Example 1' );
    Test::More::is(
        word_sorter('Hello    World!   How   are you?'),
        'are Hello How World! you?',
        'Example 2'
    );
    Test::More::is( word_sorter('Hello'), 'Hello', 'Example 3' );
    Test::More::is(
        word_sorter('Hello, World! How are you?'),
        'are Hello, How World! you?',
        'Example 4'
    );
    Test::More::is(
        word_sorter('I have 2 apples and 3 bananas!'),
        '2 3 and apples bananas! have I',
        'Example 5'
    );

    Test::More::done_testing();
}

sub _run_cli (@args) {
    if ( !@args ) {
        _run_tests();
        return;
    }
    my $sentence = join ' ', @args;
    say word_sorter($sentence);
}

_run_cli(@ARGV);

