use strict;
use warnings;
use List::Util qw/uniq/;

my $debug = 1;

my $dict = @ARGV ? shift : "../../../data/dictionary.txt";
my $i = 0;
{
	my $IN;
	unless (open $IN, "<$dict"){
		$IN = [qw/the quick brown fox jumps over the lazy dog/];
	}
	my @w;
	my %seen;
	my $best;
	my $seen = "";
	while (my $line = ref $IN eq 'GLOB' ? <$IN> : shift @$IN){
		next unless ord(substr($line,0,1)) >= 97 + $i;
		chomp $line;
		$best = $line unless defined $best;
		if (substr($best,0,1) eq substr($line,0,1)){
			next if scalar( grep{ $seen !~ /\b$_\b/ } uniq(split //, $best) ) >= scalar( grep{ $seen !~ /\b$_\b/ } uniq(split //, $line) );
			$best = $line;
			next;
		}
		#print "$best,$line\n";
		($line,$best) = ($best,$line);
		push @w,$line;
		$seen{$_}++ foreach split //, $line;
		last if keys %seen == 26;
		$seen = join(" ",keys %seen);
	}
	if (keys %seen < 26) {
		push @w, $best;
		$seen{$_}++ foreach split //, $best;
	}
	last if keys %seen < 26;
	printf "%s\n", join(" ",@w);
	if ($debug) {
		printf "=> %d words, %d letters and %d unique letters\n", scalar @w, length(join "", @w), scalar keys %seen;
		if ($debug > 1) {
			foreach (sort keys %seen) {
				my $p = join(" ", @w);
				$p =~ s/($_)/\U$1/g;
				printf "%s => %s\n", $_, $p;
			}
		}
	}
	print "\n";
	$i++;
	redo if ref $IN eq 'GLOB';
}
