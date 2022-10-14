#!/usr/bin/env raku
# :vim ft=raku sw=4 expandtab  # ∅ ≡ ∩ ≢ ∈
use v6.d;
use Test;

=begin comment
186-2: Unicode Makeover     Submitted by: Mohammad S Anwar
Given a string with possible unicode characters, create a subroutine
'makeover($str)' that replaces the unicode characters with ascii
equivalent.  For this task, let us assume it only contains alphabeticals.

Example 1
Input: $str = 'ÃÊÍÒÙ';
Output: 'AEIOU'
=end comment

=begin comment
The above spec offers no prerequisites for "conversion" but the
examples suggest that, at the least, some Unicode look-a-likes
to ASCII, with "decorations", can be replaced with what they look like.
Raku's ':ignoremark' doc is similiarly obscure.  Therefore they must be
the same.
=end comment

# sub _asciify( $char )
# Use the :ignoremark (or :m) adverb to denude, if possible, a Unicode
# Letter character to create and return an ASCII char. If not possible
# return the letter.

my @A-z = ( 'a'..'z', 'A'..'Z').flat;
my %seen;
sub _asciify( $c --> Str) {
    if not %seen{$c}:exists {
        my $r = @A-z.first: * ~~ rx:m{$c};
        %seen{$c} = $r.defined ?? $r !! $c;
    }
    %seen{$c}
}

# sub asciify( $str ) 
# Return an altered version of $str: with all Letter chars that can be,
# converted to ASCII by :ignoremark.
sub asciify( Any(Str) $in --> Str ) {
    for $in.comb -> $l { $_ ~= _asciify( $l); }
    return $_;
}

constant TEST=False;
if TEST {
    my @Test = (1..100_000,1..100_000).flat.grep( { $_.chr ~~ rx/<:L>/ });
    plan +@Test;
    for @Test -> $t is rw {
        $t.=chr;
        my $r = _asciify( $t);
        ok ( $r eq $t  or  $r ∈ ('a'..'z', 'A'..'Z').flat), "$t --> $r" ;
    }
    done-testing;
    exit;
}
our &makeover;
BEGIN { &makeover = &asciify; }

sub MAIN( $str ='startᎱ썀ÃÊÍÒÙâÊíÒÙÏĘęଽߗᎭ ᏂߵᎵᎼłǀᎲߺγϯͺʅʄªߺᏐΫάdone') {
    say "Input:  '$str'\nOutput: '", &makeover( $str), "'";
}

