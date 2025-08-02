use v5.30;

my $p0 = "Joe hit a ball, the hit ball flew far after it was hit.";
my $w0 = "hit";

my $p1 = "Perl and Raku belong to the same family. Perl is the most popular language in the weekly challenge.";
my $w1 = "the";

my @L = ($p0, $w0, $p1, $w1);

do {
    my ($p, $w) = (shift @L, shift @L);
    proc($p, $w);
} until (!@L);

sub proc(){
    my ($p, $w) = @_;
    say "Input: \$p = $p\n\t\$w = $w";
    $p =~ s/\.//g;
    $p =~ s/,//g;
    my @words = split " ", $p;
    my %f;
    foreach my $word (@words) {
	next if ($word =~ /$w/);
	$f{$word}++;
    }
    my ($ans, $max) = ("", 0);
    foreach my $word (keys %f) {
	if ($max < $f{$word}) {
	   $max = $f{$word};
	   $ans = $word;
	}
    }
    say "Output: $ans\n";
}