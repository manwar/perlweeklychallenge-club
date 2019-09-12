#!/usr/bin/perl
use Modern::Perl;

# Create script to implement Chaocipher.
# http://www.chaocipher.com/ActualChaocipher/Chaocipher-Revealed-Algorithm.pdf
# I remained true to "The Algorithm Revealed" as described in the above .pdf

my $p_msg   = "WELLDONEISBETTERTHANWELLSAID";
my $c_msg   = "OAHQHCNYNXTSZJRRHJBYHQKSOUJY";
my @disk_ct = split(//,"HXUCZVAMDSLKPEFJRIGTWOBNYQ");
my @disk_pt = split(//,"PTLNBQDEOYSFAVZKGJRIHWXUMC");

usage() if (@ARGV % 2);
my %args    = @ARGV;
my $text    = $args{'--text'}    || $p_msg;
my $verbose = $args{'--verbose'} || 0;
my $decrypt = $args{'--decrypt'} || 0; 
my $key_gen = $args{'--key-gen'} || 0;
my $ct_key  = $args{'--ct-key'}  || 0;
my $pt_key  = $args{'--pt-key'}  || 0;

$text = $c_msg if ($decrypt and $text eq $p_msg);

@disk_ct = split(//,$ct_key) if ($ct_key);
@disk_pt = split(//,$pt_key) if ($pt_key);

if ($key_gen) {
	@disk_ct = key_gen();
	@disk_pt = key_gen();
	say "keys;";
	say "ct " . join("",@disk_ct);
	say "pt " . join("",@disk_pt);
	exit;
}

chaocipher();
exit;

sub chaocipher {
	my @output; 
	# Convert text to uppercase and remove all chars not in our alphabet
	$text = uc($text);
	$text =~ s/[^A-Z]//g;
	foreach my $char (split(//,$text)) {
		print join("",@disk_ct) . " " . join("",@disk_pt) . "\n" if ($verbose);

		if ($decrypt) {
			my $i = char_pos($char, @disk_ct);
			permutate_ct($i);
			push(@output, permutate_pt($i));
		} else {
			my $i = char_pos($char, @disk_pt);
			push(@output, permutate_ct($i));
			permutate_pt($i);
		} 
	}
	print join("",@disk_ct) . " " . join("",@disk_pt) . "\n" if ($verbose);
	say join("",@output);
}

sub permutate_ct {
	my ($c) = @_;
	my ($zenith, $nadir, $hole) = (0,13,'.');
	# Steps from Chaocipher-Revealed-Algorithm.pdf
        # 1. Rotate char to zenith
        rotate(1, $c, \@disk_ct);
        # 2. Extract char at $zenith+1 and fill with "hole"
        my $extract = $disk_ct[$zenith+1];
        $disk_ct[$zenith+1] = $hole;
        # 3-4. Move chars 1 postion left and replace hole with $extract
        my @slice = (@disk_ct[$zenith+2 .. $nadir],$extract);
        splice(@disk_ct, $zenith+1, $nadir, @slice);
        return $disk_ct[0];
}

sub permutate_pt {
	my ($p) = @_;
	my ($zenith, $nadir, $hole) = (0,13,'.');
	# Steps from Chaocipher-Revealed-Algorithm.pdf
        # 1-2. Rotate char to zenith
        rotate(1, $p+1, \@disk_pt);
        # 3. Extract char at $zenith+2 and fill with "hole"
        my $extract = $disk_pt[$zenith+2];
        $disk_pt[$zenith+2] = $hole;
        # 4-5 Move chars 1 postion left and replace hole with $extract
        my @slice = (@disk_pt[$zenith+3 .. $nadir],$extract);
        splice(@disk_pt, $zenith+2, $nadir-1, @slice);
	return $disk_pt[25];
}

sub rotate {
	my ($left,$clicks,$array) = @_;
	for (1 .. $clicks) {
		if ($left) {
			push( @{$array}, shift @{$array} );
		} else {
			unshift( @{$array}, pop @{$array} );
		}
	}
}

sub char_pos {
	my ($char, @array) = @_;
	my $p;
	foreach my $i (0 .. 25) {
		$p = $i;
		last if ($array[$i] eq $char);
	}
	return $p;
}

sub key_gen {
	my @alphabet = ('A'..'Z');
        my @key;
        while (@alphabet) {
                push(@key, splice(@alphabet, int(rand @alphabet)-1, 1));
        }
        return @key;
}

sub usage {
        print <<EOU;
Usage:
	$0
	 --decrypt 1
	 --decrypt 1 --verbose 1
	             --text my-message-here
	 --decrypt 1 --text my-message-here 
	 --key-gen 1
	             --text my-message-here --ct-key the-ct-key --pt the-pt-key
	 --decrypt 1 --text my-message-here --ct-key the-ct-key --pt the-pt-key
EOU
	exit;
}

__END__

./ch-2.pl
OAHQHCNYNXTSZJRRHJBYHQKSOUJY

./ch-2.pl --decrypt 1
WELLDONEISBETTERTHANWELLSAID

./ch-2.pl --decrypt 1 --verbose 1
HXUCZVAMDSLKPEFJRIGTWOBNYQ PTLNBQDEOYSFAVZKGJRIHWXUMC
ONYQHXUCZVAMDBSLKPEFJRIGTW XUCPTLNBQDEOYMSFAVZKGJRIHW
ADBSLKPEFJRIGMTWONYQHXUCZV OYSFAVZKGJRIHMWXUCPTLNBQDE
HUCZVADBSLKPEXFJRIGMTWONYQ NBDEOYSFAVZKGQJRIHMWXUCPTL
QUCZVADBSLKPEHXFJRIGMTWONY NBEOYSFAVZKGQDJRIHMWXUCPTL
HFJRIGMTWONYQXUCZVADBSLKPE JRHMWXUCPTLNBIEOYSFAVZKGQD
CVADBSLKPEHFJZRIGMTWONYQXU YSAVZKGQDJRHMFWXUCPTLNBIEO
NQXUCVADBSLKPYEHFJZRIGMTWO BIOYSAVZKGQDJERHMFWXUCPTLN
YHFJZRIGMTWONEQXUCVADBSLKP RHFWXUCPTLNBIMOYSAVZKGQDJE
NQXUCVADBSLKPEYHFJZRIGMTWO MOSAVZKGQDJERYHFWXUCPTLNBI
XCVADBSLKPEYHUFJZRIGMTWONQ AVKGQDJERYHFWZXUCPTLNBIMOS
TONQXCVADBSLKWPEYHUFJZRIGM IMSAVKGQDJERYOHFWZXUCPTLNB
SKWPEYHUFJZRILGMTONQXCVADB RYHFWZXUCPTLNOBIMSAVKGQDJE
ZILGMTONQXCVARDBSKWPEYHUFJ LNBIMSAVKGQDJOERYHFWZXUCPT
JILGMTONQXCVAZRDBSKWPEYHUF LNIMSAVKGQDJOBERYHFWZXUCPT
RBSKWPEYHUFJIDLGMTONQXCVAZ RYFWZXUCPTLNIHMSAVKGQDJOBE
RSKWPEYHUFJIDBLGMTONQXCVAZ YFZXUCPTLNIHMWSAVKGQDJOBER
HFJIDBLGMTONQUXCVAZRSKWPEY LNHMWSAVKGQDJIOBERYFZXUCPT
JDBLGMTONQUXCIVAZRSKWPEYHF MWAVKGQDJIOBESRYFZXUCPTLNH
BGMTONQUXCIVALZRSKWPEYHFJD VKQDJIOBESRYFGZXUCPTLNHMWA
YFJDBGMTONQUXHCIVALZRSKWPE HMAVKQDJIOBESWRYFGZXUCPTLN
HIVALZRSKWPEYCFJDBGMTONQUX RYGZXUCPTLNHMFAVKQDJIOBESW
QXHIVALZRSKWPUEYCFJDBGMTON SWYGZXUCPTLNHRMFAVKQDJIOBE
KPUEYCFJDBGMTWONQXHIVALZRS NHMFAVKQDJIOBRESWYGZXUCPTL
SPUEYCFJDBGMTKWONQXHIVALZR NHFAVKQDJIOBRMESWYGZXUCPTL
OQXHIVALZRSPUNEYCFJDBGMTKW WYZXUCPTLNHFAGVKQDJIOBRMES
UEYCFJDBGMTKWNOQXHIVALZRSP GVQDJIOBRMESWKYZXUCPTLNHFA
JBGMTKWNOQXHIDVALZRSPUEYCF OBMESWKYZXUCPRTLNHFAGVQDJI
YFJBGMTKWNOQXCHIDVALZRSPUE JIBMESWKYZXUCOPRTLNHFAGVQD
WELLDONEISBETTERTHANWELLSAID

./ch-2.pl --key-gen 1
keys;
ct COTUARBGQHZWXIELJMYKNSDFVP
pt PGLNWYMFQKSUTEZVOJBXDAHIRC

./ch-2.pl --text "Turning and turning in the widening gyre the falcon cannot hear the falconer" --ct-key COTUARBGQHZWXIELJMYKNSDFVP --pt-key PGLNWYMFQKSUTEZVOJBXDAHIRC
XZDCKPDODILXCJPOIKISGJMZUZMVRCHOJAHYIZPAVZSAGJFQXUGXOIGOMIZWMIRN

./ch-2.pl --decrypt 1 --text XZDCKPDODILXCJPOIKISGJMZUZMVRCHOJAHYIZPAVZSAGJFQXUGXOIGOMIZWMIRN --ct-key COTUARBGQHZWXIELJMYKNSDFVP --pt-key PGLNWYMFQKSUTEZVOJBXDAHIRC
TURNINGANDTURNINGINTHEWIDENINGGYRETHEFALCONCANNOTHEARTHEFALCONER

