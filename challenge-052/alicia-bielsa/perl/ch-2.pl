use strict;
use warnings;
use Data::Dumper;


#Lucky Winner

#Suppose there are following coins arranged on a table in a line in random order.

#    £1, 50p, 1p, 10p, 5p, 20p, £2, 2p

#Suppose you are playing against the computer. 
#Player can only pick one coin at a time from either ends. 
#Find out the lucky winner, who has the larger amounts in total?

my %hCoinsValue = (
                    '£2' => 200,
                    '£1' => 100,
                    '50p' => 50, 
                    '20p' => 20, 
                    '10p' => 10, 
                     '5p' => 5,
                     '2p' => 2,
                     '1p' => 1
                     );
my @aCoins = keys %hCoinsValue;
my @aPlayerCoins =();
my @aComputerCoins = ();

while (scalar(@aCoins)){ 
    push (@aPlayerCoins, playerChooses()); 
    print "Player: ".join(',',@aPlayerCoins)."\n";       
    push (@aComputerCoins, computerChooses());  
    print "Computer: ".join(',',@aComputerCoins)."\n";
}

my $totalComputer = sumCoins(\@aComputerCoins);
my $totalPlayer = sumCoins(\@aPlayerCoins);


print "----------------------\nEnd of game\n";
print "Player: ".join(',',@aPlayerCoins)."\n";
print "Computer: ".join(',',@aComputerCoins)."\n"; 

if ($totalComputer >  $totalPlayer){
    print "Computer wins\n";
} elsif ($totalComputer <  $totalPlayer) {
    print "Player wins\n";
} else {
    print "Draw\n";
}


sub sumCoins {
    my $refCoins = shift;
    my $sumCoins = 0;
    foreach my $coin (@{$refCoins}){
        $sumCoins += $hCoinsValue{$coin};
    }
    return $sumCoins;
}

sub playerChooses {

    my $response = '';
    while ($response !~ /^(R|L)/){
        drawCoins();
        $response = askPlayer();
    }
    if ( $response =~ /^R/){
        return  pop(@aCoins);
    } else {
        return  shift(@aCoins);
    }  
    
}

sub computerChooses {
    my $response = '';
    drawCoins();
    if (scalar(@aCoins) == 1){
        return  pop(@aCoins);
    }
    #we dont want the player to get the 2 pound coin
    if ($aCoins[1] eq '£2'){
        $response = 'R';
    } elsif($aCoins[$#aCoins-1] eq '£2'){
        $response = 'L';
    } elsif ( $hCoinsValue{$aCoins[0]} > $hCoinsValue{$aCoins[$#aCoins]}) {
        $response = 'L';
    } else {
        $response = 'R';
    }
 
    if ( $response =~ /^R/){
        return  pop(@aCoins);
    } else {
        return   shift(@aCoins);
    }

}

sub askPlayer{
    print "Please choose coin from right or left ( R or L )\n";
    my $input = <STDIN>;
    chomp($input);
    $input  =~ s%^\s+%%;
    $input  =~ s%\s+$%%;
    return uc($input);
}

sub drawCoins {
    print "\nL".'--------' x scalar(@aCoins)."R\n";
    foreach my $coin (@aCoins){
        print $coin ."\t";
    }
    print "\n".'--------' x scalar(@aCoins)."\n";
}
