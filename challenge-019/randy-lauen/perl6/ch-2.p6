#!/usr/bin/env perl6

=begin SYNOPSIS

Write a script that can wrap the given paragraph at a specified column using the greedy algorithm.

Usage:
    # Output the default paragraph wrapped at 40 characters
    $ perl6 ch-2.p6 --line-width=40

    # Execute tests to prove the paragraph is wrapped correctly.
    $ perl6 ch-2.p6 --line-width=40 --test

=end SYNOPSIS

# Text taken from https://en.wikipedia.org/wiki/Line_wrap_and_word_wrap#Minimum_number_of_lines
constant $paragraph = q:to/END/;
A simple way to do word wrapping is to use a greedy algorithm that puts as many words on a line as possible, then moving on to the next line to do the same until there are no more words left to place. This method is used by many modern word processors, such as OpenOffice.org Writer and Microsoft Word[citation needed]. This algorithm always uses the minimum possible number of lines but may lead to lines of widely varying lengths.
END

sub wrap-lines( :$text, :$line-width ) {
    my $output;
    my $space-left = $line-width;
    for $text.words -> $word {
        if ($word.chars + 1) > $space-left {
            $output ~= "\n$word ";
            $space-left = $line-width - ($word.chars + 1);
        }
        else {
            $output ~= "$word ";
            $space-left -= ($word.chars + 1);
        }
    }
    return $output;
}

# Output the wrapped paragraph.
multi MAIN( Int :$line-width! ) {
    say wrap-lines( text => $paragraph, :$line-width );
}

# Run tests against the wrapped paragraph.
multi MAIN( :$line-width, Bool :$test! ) {
    use Test;

    my @lines = wrap-lines( text => $paragraph, :$line-width ).lines;

    # Prove all lines are <= the line width.
    for @lines -> $line {
        cmp-ok $line.chars, '<=', $line-width, "$line-width: line {++$} length is {$line.chars}";
    }

    # Combine the lines together and prove they match the original.
    is(
        @lines.join('').trim ~ "\n",
        $paragraph,
        "$line-width: paragraph put back together correctly"
    );
}


