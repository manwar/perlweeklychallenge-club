#!/usr/bin/env raku
subset DNAStr of Str where m/^ <[ACGT]>* $/;

class DNA {
    has DNAStr $.sequence handles<Str gist>;

    multi method COERCE (DNAStr $sequence ) { self.new: :$sequence }

    method nucleotide-count () {
        $!sequence.comb.Bag
    }

    method complementary ( --> DNA )   { # coerce `--> DNA()` does not work, hm
        my DNA() $ =
        $!sequence.trans: <C G T A> => <G C A T>
    }
}

multi MAIN (DNA:D() $dna = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG') {
    put $dna.nucleotide-count;
    dd $dna.complementary;
}

multi MAIN (Bool :$test!) {
    use Test;
    my DNA() @dna = 'TAGAC', 'ATCTG';
    is-deeply @dna[0].complementary, @dna[1];
    is        @dna[1].complementary, @dna[0];
    is-deeply @dna[0].nucleotide-count,     bag <A A G T C>;
    is        @dna[1].nucleotide-count.<T>, 2;
    done-testing;
}
