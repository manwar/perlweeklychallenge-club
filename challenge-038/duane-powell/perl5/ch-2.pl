#!/usr/bin/perl
use warnings;
use strict;
use feature 'say';
use Math::Combinatorics 'permute';

# Word Game Problem:
# Lets assume we have tiles as listed below, with an alphabet (A..Z) printed on them. Each tile has a value, e.g. A (1 point), 
# B (4 points) etc. You are allowed to draw 7 tiles from the lot randomly. Then try to form a word using the 7 tiles with maximum points 
# altogether. You dont have to use all the 7 tiles to make a word. You should try to use as many tiles as possible to get the maximum points.

# Solution: Generate every permutation from 7 random tiles, find all words that match a permutation, find the highest value word and print it
# We need three data structures, 1) an array of tiles @TILE 2) a hash of tile values %$POINT 3) a hash of all words less than 8 chars, %SEVEN_LETTER_WORD

my $verbose = shift; # list all words with any value

# Take the problem description and parse into the GLOBAL array @TILE
my @TILE; 
my $problem = 'A (x8), G (x3), I (x5), S (x7), U (x5), X (x2), Z (x5) E (x9), J (x3), L (x3), R (x3), V (x3), Y (x5) F (x3), D (x3), P (x5), W (x5) B (x5), N (x4) T (x5), O (x3), H (x3), M (x4), C (x4)';
my @matches;
push @matches, [$1, $2] while $problem =~ m/(.) (\(x\d\))/g;
foreach (@matches) {
        my ($char,$repeat) = @{$_};
        $repeat =~ m/(\d)/;
	push @TILE, split(//,($char x $1));
}

my $POINT = { # GLOBAL hashref of the tile values, $POINT
	A => 1,
	G => 1,
	I => 1,
	S => 1,
	U => 1,
	X => 1,
	Z => 1,
	
	E => 2,
	J => 2,
	L => 2,
	R => 2,
	V => 2,
	Y => 2,

	F => 3,
	D => 3,
	P => 3,
	W => 3,

	B => 4,
	N => 4,

	T => 5,
	O => 5,
	H => 5,
	M => 5,
	C => 5,
	
	K => 10,
	Q => 10,
};


my %SEVEN_LETTER_WORD;                                    # GLOBAL hash of all words less than 8 chars
seven_letter_words_get();                                 # populate hash from text file: ./all words.less.than.8.letters.txt

my @seven_random_tiles = seven_random_tiles_get();        # generate seven random tiles
say "Seven tiles are: " . join(',',@seven_random_tiles);

my @word = seven_letter_words_spell(@seven_random_tiles); # find all words we can spell with these tiles
my ($word,$value) = most_valuable_word_find(@word);       # find most valuable word in @word

say "Most valuable word is: $word at $value points.";
exit;


sub seven_letter_words_get {
	my $f = "./all.words.less.than.8.letters.txt";
	open(my $fh, "<", $f) or die "Can not open $f $!";
	while (<$fh>) {
		chomp;
		my $w = uc($_);
		$SEVEN_LETTER_WORD{$w} = 1;
	}
	close($fh);
}

sub seven_random_tiles_get {
	my @seven;
	foreach (1..7) {
		my $r = int(rand(scalar @TILE));
		push @seven, $TILE[$r];
		splice @TILE, $r, 1;
	}
	return @seven;
}

sub seven_letter_words_spell {
	# spell every word possible by matching permutations to our word list
	my @seven = @_; 
	my @word;
	my @perm = map { join "", @$_ } permute(@seven);
	my %tried; # hash of 2,3,4,5,6 letter words we have tried, needed because we're gonna try smaller words within the thousands of permutations --there will be dups
	foreach my $w (@perm) { # iterate over all permutations
		foreach my $i (2..7) { # try shorter words of 2-to-6 chars as well as the 7 char permutation itself
			my $w = substr($w,0,$i);
			next if (defined $tried{$w});
			$tried{$w} = 1;
			push @word, $w if (defined $SEVEN_LETTER_WORD{$w}); # we found a permutation that's an actual word
		}
	}
	return @word;
}

sub most_valuable_word_find {
	my @word = @_;
	my $best_value = 0;
	my $best_word;
	say "\nWords found:" if ($verbose);
	foreach my $w (@word) {
		my @letter = split(//,$w);
		my $value = 0;
		$value += $POINT->{$_} foreach (@letter);
		if ($value > $best_value) {
			$best_value = $value;
			$best_word = $w;
		}
		print "$w=$value " if ($verbose);
	}
	say "\n" if ($verbose);
	return ($best_word, $best_value);
}

__END__
./ch-2.pl 
Seven tiles are: T,Z,B,P,E,J,Y
Most valuable word is: BYTE at 13 points.

./ch-2.pl 
Seven tiles are: C,O,T,H,I,G,J
Most valuable word is: GOTHIC at 22 points.

./ch-2.pl 
Seven tiles are: Y,S,U,T,E,E,W
Most valuable word is: SWEETY at 15 points.


./ch-2.pl 1 
Seven tiles are: B,S,O,E,S,N,T

Words found:
BS=5 BSO=10 BSOT=15 BSE=7 BSES=8 BSS=6 BSSE=8 BSN=9 BST=10 BO=9 BOS=10 BOSE=12 BOSS=11 BOSSET=18 BOSN=14 BOE=11 BON=13 BONS=14 BONE=15 BONES=16 BOT=14 BOTS=15 BOTE=16 BOTES=17 BE=6 BES=7 BESOT=17 BESOTS=18 BESS=8 BEST=12 BESTS=13 BEN=10 BENS=11 BENO=15 BENT=15 BENTS=16 BET=11 BETS=12 BETSO=17 BETOSS=18 BETON=20 BETONS=21 BN=8 BNS=9 BNET=15 BT=9 BTS=10 BTO=14 BTE=11 BTN=13 SB=5 SBE=7 SBS=6 SO=6 SOB=10 SOBS=11 SOE=8 SOS=7 SON=10 SONE=12 SONES=13 SONET=17 SONS=11 SOT=11 SOTS=12 SE=3 SEBS=8 SES=4 SEST=9 SESTON=18 SEN=7 SENSO=13 SENT=12 SENTS=13 SET=8 SETO=13 SETON=17 SETONS=18 SETS=9 SS=2 SSB=6 SSO=7 SSE=4 SSN=6 SST=7 SSTO=12 SN=5 SNOB=14 SNOBS=15 SNOT=15 SNOTS=16 SNEB=11 SNET=12 ST=6 STB=10 STOB=15 STOBS=16 STONE=17 STONES=18 STE=8 STEN=12 STENO=17 STENOS=18 STS=7 STN=10 OB=9 OBS=10 OBE=11 OBES=12 OS=6 OSB=10 OSE=8 OSES=9 OSS=7 OSSE=9 OSSET=14 OSN=10 OST=11 OE=7 OES=8 ON=9 ONS=10 ONSET=17 ONSETS=18 ONE=11 ONES=12 ONT=14 OT=10 OTB=14 OTBS=15 OTS=11 OTE=12 OTES=13 EB=6 EBS=7 EBON=15 EBONS=16 EBN=10 ES=3 ESB=7 ESBON=16 ESO=8 ESS=4 ESN=7 EST=8 EO=7 EOS=8 EON=11 EONS=12 EOT=12 EN=6 ENS=7 ENO=11 ENOS=12 ENT=11 ET=7 ETS=8 ETO=12 ETON=16 ETN=11 NB=8 NBS=9 NBO=13 NBE=10 NS=5 NSB=9 NSO=10 NSE=7 NST=10 NSTS=11 NO=9 NOB=13 NOBS=14 NOBE=15 NOS=10 NOSE=12 NOSES=13 NOE=11 NOES=12 NOT=14 NOTS=15 NOTE=16 NOTES=17 NE=6 NEB=10 NEBS=11 NEBO=15 NES=7 NESS=8 NEST=12 NESTO=17 NESTS=13 NEO=11 NET=11 NETS=12 NETO=16 NT=9 NTS=10 NTSB=14 NTO=14 TB=9 TBS=10 TBO=14 TS=6 TSO=11 TSE=8 TSS=7 TO=10 TOB=14 TOBE=16 TOS=11 TOSS=12 TOE=12 TOES=13 TON=14 TONS=15 TONE=16 TONES=17 TE=7 TEB=11 TES=8 TESS=9 TEN=11 TENS=12 TENSO=17 TENO=16 TN=9 TNB=13 

Most valuable word is: BETONS at 21 points.


./ch-2.pl 1 
Seven tiles are: O,I,F,F,T,P,E

Words found:
OIT=11 OIE=8 OF=8 OFF=11 OFT=13 OT=10 OTF=13 OTE=12 OP=8 OPF=11 OPT=13 OPE=10 OE=7 OEP=10 IO=6 IOF=9 IOT=11 IOP=9 IF=4 IFO=9 IFF=7 IFE=6 IT=6 ITO=11 ITE=8 IP=4 IPO=9 IPT=9 IPE=6 IE=3 IETF=11 FO=8 FOT=13 FOP=11 FOE=10 FOETI=16 FI=4 FIO=9 FIOT=14 FIFO=12 FIFE=9 FIT=9 FIP=7 FIE=6 FIEF=9 FF=6 FFI=7 FFT=11 FT=8 FTP=11 FTPI=12 FTE=10 FP=6 FPO=11 FPE=8 FE=5 FEI=6 FEIF=9 FET=10 FEP=8 TO=10 TOI=11 TOFF=16 TOP=13 TOPI=14 TOPE=15 TOE=12 TI=6 TIFF=12 TIP=9 TIPOFF=20 TIPE=11 TIE=8 TFP=11 TP=8 TPO=13 TPI=9 TPE=10 TE=7 TEF=10 TEFF=13 PO=8 POI=9 POF=11 POT=13 POTI=14 POTE=15 POE=10 POET=15 PI=4 PIO=9 PIF=7 PIFF=10 PIT=9 PIE=6 PIET=11 PF=6 PFFT=14 PT=8 PTO=13 PTI=9 PTFE=13 PTE=10 PE=5 PEI=6 PET=10 PETO=15 PETOFI=19 PETI=11 PETFI=14 EO=7 EOF=10 EOT=12 EI=3 EF=5 EFI=6 EFF=8 EFT=10 ET=7 ETO=12 ETF=10 EP=5 EPI=6 EPIT=11 EPT=10 

Most valuable word is: TIPOFF at 20 points.


