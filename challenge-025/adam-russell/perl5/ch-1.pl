use strict;
use warnings;
##
# Create script to implement Chaocipher.
##
use Deck;

sub split_deck{
    my($deck) = @_;
    my(@red, @black);
    my $card = $deck->deal_one();
    while($card){
        if($card->{suit}){
            push @black, $card;
        } 
        else{
            push @red, $card; 
        } 
        $card = $deck->deal_one();
    }
    return(new Deck(\@red), new Deck(\@black)); 
}

sub encrypt_letter{
    my($letter, $left, $right) = @_;  
    my $index = 0; 
    my $plaintext_index; 
    my $card = $right->deal_one();
    while($card){
        if($card->{letter} eq $letter){      
            $plaintext_index = $index;  
            last; 
        }
        $card = $right->deal_one();
        $index++; 
    }  
    my $cyphertext = $left->card_at($plaintext_index)->{letter}; 
    $left->left_permute(); 
    $right->right_permute();
    return $cyphertext;  
}

sub decrypt_letter{
    my($letter, $left, $right) = @_;  
    my $index = 0; 
    my $plaintext_index; 
    my $card = $left->deal_one();
    while($card){
        if($card->{letter} eq $letter){      
            $plaintext_index = $index;  
            last; 
        }
        $card = $left->deal_one();
        $index++; 
    }  
    my $plaintext = $right->card_at($plaintext_index)->{letter}; 
    $left->left_permute(); 
    $right->right_permute(); 
    return $plaintext; 
}


MAIN:{
    my $message = <DATA>; 
    chomp($message); 
    my $deck = new Deck();
    $deck->shuffle(); 
    my ($left, $right) = split_deck($deck); 
    my @letters = split(//, $message);
    my @cyphertext;
    for my $c (@letters){ 
        push @cyphertext, encrypt_letter($c, $left, $right);
    } 
    print join("", @cyphertext) . "\n"; 
    my @plaintext;
    for my $c (@cyphertext){ 
        push @plaintext, decrypt_letter($c, $left, $right);
    } 
    print join("", @plaintext) . "\n"; 
}

__DATA__
ATTACKATDAWN
