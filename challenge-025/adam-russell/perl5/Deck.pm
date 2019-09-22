package Deck;

use boolean;

use CypherCard;  
use Suit qw/DIAMOND HEART SPADE CLUB/;
use Rank qw/A TWO THREE FOUR FIVE SIX SEVEN EIGHT NINE TEN J Q K/;

use constant ZENITH => 0; 
use constant NADIR => 13; 

our $index = 0;

sub new{
    my ($pkg, $pile) = @_;
    my $self = $pile || create(); 
    bless($self, $pkg);
    $index = 0; 
    return $self;    
} 

##
# Fisher-Yates shuffle
##
sub shuffle{
    my ($self) = @_;
    my $i = @{$self};
    while(--$i){
        my $j = int(rand($i + 1));
        @{$self}[$i, $j] = @{$self}[$j, $i];
    }
    $index = 0; 
}

sub print{
    my ($self) = @_;
    for my $card (@{$self}){
        print $card->{suit}." ".$card->{rank}."\n";  
    }   
}

sub deal_one{
    my ($self) = @_;
    return $self->[$index++];
} 

sub card_at{
    my ($self, $i) = @_;
    return $self->[$i];
} 

sub left_permute{
    my($self, $i) = @_;
    my $permutated = []; 
    for(my $j = ($i - 1); $j >= 0; $j--){
        push @{$permutated}, $self->card_at($j); 
    }    
    for(my $j = 51; $j > $i; $j--){
        push @{$permutated}, $self->card_at($j); 
    }    
    unshift @{$permutated}, $self->card_at($i);  
    my $zenith_plus_1 = $permutated->[ZENITH + 1]; 
    splice @{$permutated}, ZENITH + 1, 1;
    splice @{$permutated}, NADIR, 0, $zenith_plus_1;
    $self = new Deck($permutated); 
} 

sub right_permute{
    my($self, $i) = @_;
    my $permutated = []; 
    for(my $j = ($i - 1); $j >= 0; $j--){
        push @{$permutated}, $self->card_at($j); 
    }    
    for(my $j = 51; $j > $i; $j--){
        push @{$permutated}, $self->card_at($j); 
    }    
    unshift @{$permutated}, $self->card_at($i);  
    my $bottom = $permutated->[ZENITH]; 
    splice @{$permutated}, ZENITH, 1;
    push @{$permutated}, $bottom;
    my $zenith_plus_2 = $permutated->[ZENITH + 2]; 
    splice @{$permutated}, ZENITH + 2, 1;
    splice @{$permutated}, NADIR, 0, $zenith_plus_2;
    $self = new Deck($permutated); 
} 

sub create{
    my @deck=();  
    while(<DATA>){
        chomp;
        push(@deck, new CypherCard(eval($_)));
    }    
    return \@deck;  
}

true;  

__DATA__
{suit => DIAMOND, rank => A, letter => q/N/}
{suit => DIAMOND, rank => TWO, letter => q/O/} 
{suit => DIAMOND, rank => THREE, letter => q/P/} 
{suit => DIAMOND, rank => FOUR, letter => q/Q/} 
{suit => DIAMOND, rank => FIVE, letter => q/R/} 
{suit => DIAMOND, rank => SIX, letter => q/S/} 
{suit => DIAMOND, rank => SEVEN, letter => q/T/} 
{suit => DIAMOND, rank => EIGHT, letter => q/U/} 
{suit => DIAMOND, rank => NINE, letter => q/V/} 
{suit => DIAMOND, rank => TEN, letter => q/W/} 
{suit => DIAMOND, rank => J, letter => q/X/} 
{suit => DIAMOND, rank => Q, letter => q/Y/} 
{suit => DIAMOND, rank => K, letter => q/Z/} 
{suit => HEART, rank => A, letter => q/A/}
{suit => HEART, rank => TWO, letter => q/B/} 
{suit => HEART, rank => THREE, letter => q/C/} 
{suit => HEART, rank => FOUR, letter => q/D/} 
{suit => HEART, rank => FIVE, letter => q/E/} 
{suit => HEART, rank => SIX, letter => q/F/} 
{suit => HEART, rank => SEVEN, letter => q/G/} 
{suit => HEART, rank => EIGHT, letter => q/H/} 
{suit => HEART, rank => NINE, letter => q/I/} 
{suit => HEART, rank => TEN, letter => q/J/} 
{suit => HEART, rank => J, letter => q/K/} 
{suit => HEART, rank => Q, letter => q/L/} 
{suit => HEART, rank => K, letter => q/M/} 
{suit => SPADE, rank => A, letter => q/A/}
{suit => SPADE, rank => TWO, letter => q/B/} 
{suit => SPADE, rank => THREE, letter => q/C/} 
{suit => SPADE, rank => FOUR, letter => q/D/} 
{suit => SPADE, rank => FIVE, letter => q/E/} 
{suit => SPADE, rank => SIX, letter => q/F/} 
{suit => SPADE, rank => SEVEN, letter => q/G/} 
{suit => SPADE, rank => EIGHT, letter => q/H/} 
{suit => SPADE, rank => NINE, letter => q/I/} 
{suit => SPADE, rank => TEN, letter => q/J/} 
{suit => SPADE, rank => J, letter => q/K/} 
{suit => SPADE, rank => Q, letter => q/L/} 
{suit => SPADE, rank => K, letter => q/M/} 
{suit => CLUB, rank => A, letter => q/N/}
{suit => CLUB, rank => TWO, letter => q/O/} 
{suit => CLUB, rank => THREE, letter => q/P/} 
{suit => CLUB, rank => FOUR, letter => q/Q/} 
{suit => CLUB, rank => FIVE, letter => q/R/} 
{suit => CLUB, rank => SIX, letter => q/S/} 
{suit => CLUB, rank => SEVEN, letter => q/T/} 
{suit => CLUB, rank => EIGHT, letter => q/U/} 
{suit => CLUB, rank => NINE, letter => q/V/} 
{suit => CLUB, rank => TEN, letter => q/W/} 
{suit => CLUB, rank => J, letter => q/X/} 
{suit => CLUB, rank => Q, letter => q/Y/} 
{suit => CLUB, rank => K, letter => q/Z/} 
