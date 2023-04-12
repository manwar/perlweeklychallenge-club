use v5.30.0;
my $word = "Perl";
my @jump = (2, 22, 19, 9);
#my $word = "Raku";
#my @jump = (24, 4, 7, 17);
my $alph = 'abcdefghijklmnopqrstuvwxyz';
my @alph = split("",$alph);
my @letter = split("",$word);
my $output;
my $outword;
foreach my $i (0 .. $#letter) {
    my $ucflag =  ($letter[$i] eq uc $letter[$i]);
    $letter[$i] = lc $letter[$i];
    my $index = index($alph,$letter[$i]);    
    $letter[$i] = uc $letter[$i] if ($ucflag);
    my $outdex = ($index+$jump[$i]) % 26;
    if ($ucflag) {
	$outword .= uc $alph[$outdex];
    } else {
	$outword .= $alph[$outdex];
    }
    my $sp; $sp = " " if ($jump[$i]<=9);
    $output .= lc $letter[$i]." + ".$sp.$jump[$i]." -> $alph[$outdex]\n";
}
say "Input: \$word: $word and \@jump: @jump";
say "Output: $outword";
chomp $output;
say "\n$output";
