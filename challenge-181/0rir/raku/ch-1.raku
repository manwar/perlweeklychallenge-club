#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢
use v6.d;

use Text::MiscUtils::Layout;

=begin comment
Task 1: Sentence Order      Submitted by: Mohammad S Anwar
Given a paragraph.  Order each sentence alphanumerically
and print the whole paragraph.
=end comment

my $Input = q:to/INPUT/;
    All he could think about was how it would all end. There was
    still a bit of uncertainty in the equation, but the basics
    were there for anyone to see. No matter how much he tried to
    see the positive, it wasn't anywhere to be seen. The end was
    coming and it wasn't going to be pretty.
    INPUT

.say for text-wrap 60,
    ( join '. ',
        map { 
            ( sort {$^a.fc cmp $^b.fc},
                    ( $_.split( / \s+ /, :skip-empty ))
            ).join( ' ')
        }, $Input.split( / '.' /, :skip-empty )
    ).trim;

exit;
