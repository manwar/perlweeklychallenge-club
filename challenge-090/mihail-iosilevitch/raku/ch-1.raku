use v6;

my $DNA = "GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG";

my $C = 0;
my $G = 0;
my $A = 0;
my $T = 0;
for $DNA.split("", :skip-empty) -> $nucleobase {
	given $nucleobase {
		when "C" { $C += 1; print "G"; }
		when "G" { $G += 1; print "C"; }
		when "A" { $A += 1; print "T"; }
		when "T" { $T += 1; print "A"; }
	}
}
say "";

say "Cytosine: " ~ $C;
say "Guanine: " ~ $G;
say "Adenine: " ~ $A;
say "Thymine: " ~ $T;
say "Total: " ~ [+] $C, $G, $A, $T;
