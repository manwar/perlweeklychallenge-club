use v5.30;
use Algorithm::Permute;
my @names = ('Mr. Wall',
	     'Mrs. Wall',
	     'Mr. Anwar',
	     'Mrs. Anwar',
	     'Mr. Conway',
	     'Mr. Cross',
	 );
#@names = ('Mr. Wall', 'Mrs. Wall', 'Mr. Cringle');

say "Input: \@names = (". join(", ", @names) . ")";
say "Output: ";
my @seq;
my @tried;
my $endflag = 1;
my $N = factorial(scalar @names);
my $index = int rand $N;
my @P;
load_perms();

do {
    @seq = random_pls($index);
    if (check(@seq)) {
	$endflag = 0;
    } else {
	$endflag++;
	push @tried, $index;
	my $test_string = join(" ", @tried);
	my $flag = 0;
	my $x;
	do {
	    $x = int rand $N;
	    unless ( $test_string =~ m/$x/ ) {
		$flag = 1;
	    }
	} until ($flag);
	$index = $x;
    }
} until ( ($endflag == 0) or ($endflag == $N) );

foreach my $i (0 .. $#seq - 1) {
    print $names[$seq[$i]] . " --> ";
}
print $names[$seq[$#seq]]."\n";


sub load_perms {
    my $p = Algorithm::Permute->new([0 .. $#names]);
    while (my @perm = $p->next) {
	push @P, \@perm;
    }
}

sub random_pls {
    my $index = shift;
    return @{$P[$index]};
}

sub factorial {
    my ($n) = @_;
    return 1 if $n == 0;
    return factorial($n-1) * $n;
}

sub check {
    my @seq = @_;
    my @surname;
    foreach my $name (@names) {
	my @chunk = split(" ", $name);
	push @surname, $chunk[1];
    }
    for my $i (0 .. $#seq - 1) {
	if ($surname[$seq[$i]] eq $surname[$seq[$i + 1]]) {
	    return 0;
	}
    }
    return 0 if ($surname[$seq[0]] eq $surname[$seq[$#seq]]);
    return 1;
}
