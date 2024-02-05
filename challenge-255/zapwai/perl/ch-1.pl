use v5.30;

my $s0 = "Perl";
my $t0 = "Preel";

my $s1 = "Weekly";
my $t1 = "Weeakly";

my $s2 = "Box";
my $t2 = "Boxy";
my @L = ($s0, $t0, $s1, $t1, $s2, $t2);

do {
    my ($s, $t) = (shift @L, shift @L);     
    proc($s,$t);
} until (!@L);
    
sub proc() {
    my ($s, $t) = @_;
    say "Input: \$s = $s, \$t = $t";
    my @S = split "", $s;
    my @T = split "", $t;
    my %Sfreq;
    my %Tfreq;
    for (@S) {
	$Sfreq{$_}++;
    }
    for (@T) {
	$Tfreq{$_}++;
    }    
    for my $key (keys %Tfreq) {
	if ((!$Sfreq{$key}) or ($Sfreq{$key} < $Tfreq{$key})) {
	   say "Output: $key";
	}
    }
}