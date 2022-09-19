use v6;

# AUTHOR: Robert DiCicco
# DATE: 2022-09-12
# Challenge 182 Max Index ch-1.pl ( Raku )

my @n = (5, 2, 9, 1, 7, 6);

my %n_ndx = ();

my $count = 0;

for (@n) {

  %n_ndx{$_} = $count++;

}

my @n_srt = @n.sort.reverse;

print "Input: \@n = \(" ~ @n ~ "\)\n";

print "Output: %n_ndx{@n_srt[0]}\n";
