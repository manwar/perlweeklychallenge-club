use v5.38;

my %D;
@D{0 .. 20, 30,40,50,60,70,80,90,} = qw| zero one two three four five six seven eight nine ten eleven twelve thirteen fourteen fifteen sixteen seventeen eighteen nineteen twenty thirty forty fifty sixty seventy eighty ninety |;

my @T = qw|hundred thousand million billion trillion|;

sub core($n) {			# transform numbers less than 1000
    my ($ones, $tens, $hundreds) = ($n % 10, (int ($n % 100 - $n % 10) / 10), int($n / 100));
    my $name;
    if ($ones == 0 && $tens == 0 && $hundreds == 0) {
	$name = "zero";
    } else {
	$name = ($hundreds != 0) ? "$D{$hundreds} hundred " : "";
	$name .= ($tens != 0) ? "$D{$tens*10} " : "";
	$name .= ($ones != 0) ? $D{$ones} : "";
    }
    return $name;
}

sub eng($num) {
    my $len = length($num);
    my $exp = int(($len - 1) / 3);
    my @exponents;
    push @exponents, $T[$_] for reverse (0 .. $exp);
    my @chunk;
    for my $i (0 .. $exp) {
	my $ind = $len - 3*$i -3;
	if ($ind >= 0) {
	    push @chunk, substr($num, $ind, 3);
	} else {
	    push @chunk, substr($num, 0, $len % 3);
	}
    }
    @chunk = reverse @chunk;
    my $out;
    for my $i (0 .. $exp) {
	$out .= core($chunk[$i]);
	$out .= " $exponents[$i] " unless ($i == $exp);
    }
    return $out;
}

sub proc(@l) {
    say "Input: @l";
    my @name;
    for my $number (@l) {
	my $name;
	if ($number < 0) {
	    $name = "minus ";
	    $number *= (-1);
	}
	$name .= eng($number);
	if (length($name) > 4 && $name =~ "zero") { # remove 'zero' from nontrivial numbers
	    $name =~ s/zero//;
	}
	if (substr($name, -1, 1) eq " ") { # cleanup some spaces
	    $name = substr($name, 0, -1);
	}
	push @name, $name;
    }
    my @sorted = sort (@name);
    say "\t[" . join(", ", @name) . "]";
    print "Output: ";
    say join(", ", @sorted);
}

my @l = (6,7,8,9,10);
proc(@l);
@l = (-3, 0, 1000, 99);
proc(@l);
@l = (1, 2, 3, 4, 5);
proc(@l);
@l = (0, -1, -2, -3, -4);
proc(@l);
@l = (100, 101, 102);
proc(@l);
