#!/usr/bin env perl6

=begin comment
Challenge 008#2

Write a function, ‘center’, whose argument is a list of strings, which will
be lines of text. The function should insert spaces at the beginning of the
lines of text so that if they were printed, the text would be centered, and
return the modified lines.
=end comment

sub center( *@strings --> List ) {
    my @sorted  = @strings.sort({.chars});
    my $max-len = @sorted.tail.chars;
    return @sorted.map({
        ( ' ' x (.chars - $max-len).abs div 2, $_).join
    }).list;
}
