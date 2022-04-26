use strict;
use warnings;
my $debug = 0;

my($key,$msg2encrypt) = @ARGV ? @ARGV : ("playfair example", "hide the gold in the tree stump"); 
$key = lc($key);
$msg2encrypt = lc($msg2encrypt);
my $converter = genConverter($key);
my $msg2decrypt = &$converter($msg2encrypt); 
printf 'encrypt("%s", "%s") = "%s"'."\n\n", $key, $msg2encrypt, $msg2decrypt; 
unless (@ARGV){
	$key = "perl and raku";
	$converter = genConverter($key);
	$msg2decrypt = "siderwrdulfipaarkcrw";
}
printf 'decrypt("%s", "%s") = "%s"'."\n\n", $key, $msg2decrypt, &$converter($msg2decrypt,1);

sub genConverter{
	my $key = shift;
	my %seen;
	my @c;
	my ($i,$j) = (0,0);
	foreach ( ( $key =~ /(\w)/g, 'a'..'z') ) {
		next if $seen{$_};
		if ( $_ eq 'i' || $_ eq 'j') {
			$seen{i}=[$i,$j];
			$seen{j}=[$i,$j];
		} else {
			$seen{$_}=[$i,$j];
		}
		$c[$i][$j] = $_;
		$j++;
		unless ($j < 5) {
			$j = 0;
			$i++;
		}
		last unless $i < 5;
	}
	if ($debug){
		print join(" ", @$_)."\n" foreach @c;
		printf("%s => (%s)\n", $_, join(", ",@{$seen{$_}})) foreach sort{$a cmp $b} keys %seen;
		printf "%d\n", scalar(keys %seen);
	}
	return sub{
		my $msg = shift;
		my $o = -1;
		unless (@_){
			$msg =~ s/\s//g;
			$msg =~ s/(\w)(\1)/$1x$2/g;
			$msg .= 'x' if length($msg) % 2;
			$o = 1;
		}
		my @res;
		foreach my $pair ($msg =~ /(\w\w)/g){
			my($a,$b) = @seen{$pair =~ /(\w)(\w)/};
			#printf "$pair => (%s),(%s)\n", join(", ",@$a), join(", ",@$b);
			my($w,$h) = ($a->[1] - $b->[1], $a->[0] - $b->[0]);
			#printf "$pair => %s\n", $w==0 ? "column" : $h==0 ? "row" : "rectangle";
			if ($w==0){
				push @res, $c[($a->[0]+$o)%5][$a->[1]], $c[($b->[0]+$o)%5][$b->[1]]; 
			} elsif ($h==0){
				push @res, $c[$a->[0]][($a->[1]+$o)%5], $c[$b->[0]][($b->[1]+$o)%5]; 
			} else {
				push @res, $c[$a->[0]][$a->[1]-$w], $c[$b->[0]][$b->[1]+$w]; 
			}
			#printf "$pair => %s\n", join("",@res[-2,-1]);
		}
		return join("",@res);
	}
}
