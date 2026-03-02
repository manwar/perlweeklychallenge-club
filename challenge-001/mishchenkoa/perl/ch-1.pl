#!/usr/bin/perl
use warnings;

# References:
# 1. https://www.geos.ed.ac.uk/~bmg/software/Perl%20Books/OReilly.Perl.Cookbook.pdf
# 2. https://cse.buffalo.edu/faculty/miller/Courses/WWW-Sem/Sp97/Presentations/Perl-Solovey/perltut/sandtr.html


sub replace_and_count{
    # Replace a lower-case letter with its upper-case equivalent in a string.
    my $letter_to_search_and_replace = shift;
    my $text = shift;
    my $uppercase_letter = uc($letter_to_search_and_replace);
    my %result;

    my $count = $text =~ s/$letter_to_search_and_replace/$uppercase_letter/g;
    print "$text\n";
    print "$count\n";
    $result{"number_of_replacements"} = $count;
    $result{"text"} = $text;
    return \%result;

}

replace_and_count("e", "HEre is my text. Hello, world. Create a new dir (or folder?). It depends.");
