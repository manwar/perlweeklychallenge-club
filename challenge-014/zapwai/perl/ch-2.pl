use v5.38;
my $str = <<ENDL;
	      Alabama 	AL
	      Kentucky 	KY
	      Ohio 	OH
	      Alaska 	AK
	      Louisiana	LA
	      Oklahoma 	OK
	      Arizona 	AZ
	      Maine 	ME
	      Oregon 	OR
	      Arkansas 	AR
	      Maryland 	MD
	      Pennsylvania 	PA
	      Massachusetts 	MA
	      California      CA
	      Michigan	      MI
	      RhodeIsland 	RI
	      Colorado 	CO
	      Minnesota 	MN
	      SouthCarolina 	SC
	      Connecticut  CT
	      Mississippi  MS
	      SouthDakota 	SD
	      Delaware 	DE
	      Missouri 	MO
	      Tennessee	TN
	      Montana 	MT
	      Texas 	TX
	      Florida 	FL
	      Nebraska 	NE
	      Georgia  GA
	      Nevada      NV
	      Utah      UT
	      NewHampshire 	NH
	      Vermont 	VT
	      Hawaii 	HI
	      NewJersey 	NJ
	      Virginia	      VA
	      Idaho	      ID
	      NewMexico     	NM
	      Illinois 	IL
	      NewYork 	NY
	      Washington 	WA
	      Indiana 	IN
	      NorthCarolina 	NC
	      WestVirginia 	WV
	      Iowa 	IA
	      NorthDakota 	ND
	      Wisconsin 	WI
	      Kansas 	KS
	      Wyoming 	WY
ENDL
open my $fh, "<words" or die;
my @dict = <$fh>;
close $fh;
chomp @dict;
my @words;
foreach (@dict) {
    if (length($_) % 2 == 0) {
	push @words, uc $_ unless ($_ =~ /[b|q]/);
    }
}
my %h = split(" ", $str);
my @letters = sort values %h;
my @composites = @letters;
my $n = 0;
my $len = @letters;
do {
    my @newlist;
    foreach my $item (@composites) {
	for my $i (0 .. $#letters) {
	    push @newlist, $item.$letters[$i];
	}
    }
    $n++;
    push @composites, @newlist;
} while ( $n < 3 );		# max length of words is 2(n+1)

my @list = grep { /[AEIOU]+/ } @composites;

my $words = join(" ", @words);
my $let = "A";
for my $comp (@list) {
    say $comp if ($words =~ / $comp /);
    if ($let ne substr($comp,0,1)) {
	say $let;
	$let = substr($comp,0,1);
    }
}

# MAINLAND
# MANDARIN
# MEMORIAL
