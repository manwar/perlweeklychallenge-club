use strict; 
use warnings;
##
# Lets assume we have tiles with an alphabet (A..Z) printed on them. 
# Each tile has a value, e.g. A (1 point), B (4 points) etc. You are 
# allowed to draw 7 tiles from the lot randomly. Then try to form a 
# word using the 7 tiles with maximum points altogether. You don’t 
# have to use all the 7 tiles to make a word. You should try to use 
# as many tiles as possible to get the maximum points.
##
use constant DICTIONARY => "/usr/share/dict/words";
use Readonly; 
Readonly::Hash my %CHAR_VALUES => (
    A => 1, B => 4, C => 5, D => 3, E => 2,
    F => 3, G => 1, H => 5, I => 1, J => 2,
    K => 10, L => 2, M => 5, N => 4, O => 5,
    P => 3, Q => 10, R => 2, S => 1, T => 5,
    U => 1, V => 2, W => 3, X => 1, Y => 2,
    Z => 1
); 

Readonly::Hash my %CHAR_FREQUENCIES => (
    A => 8, B => 5, C => 4, D => 3, E => 9,
    F => 3, G => 3, H => 3, I => 5, J => 3,
    K => 2, L => 3, M => 4, N => 4, O => 3,
    P => 5, Q => 2, R => 3, S => 7, T => 5,
    U => 5, V => 3, W => 5, X => 2, Y => 5,
    Z => 5 
);

sub draw7{
    my @letters;
    my @seven;
    for my $k (keys %CHAR_FREQUENCIES){
        push @letters, ($k) x $CHAR_FREQUENCIES{$k};
    } 
    for(0..6){
        my $r = int(rand(@letters));
        push @seven, splice @letters, $r, 1;        
    }  
    return @seven; 
} 

sub find_max_score{
    my @seven = @_; 
    my $max_score = 0; 
    my $max_word; 
    my $max_letters; 
    open(WORDS, DICTIONARY);  
    while(<WORDS>){
        chomp($_);
        my $word = uc($_);
        my $temp = $word;
        my @letters; 
        for my $c (@seven){
            $word =~ s/(\Q$c\E)//;
            push @letters, $1 if $1; 
        }
        if(!$word){  
            my $sum = 0;
            map {$sum += $_} map{$CHAR_VALUES{$_}} @letters;  
            if($max_score < $sum){ 
                $max_word = $temp;
                $max_letters = join(", " , @letters);
                $max_score = $sum;
            }
        }
    }  
    close(WORDS); 
    return $max_word, $max_letters, $max_score; 
}

MAIN:{
    my @letters = draw7(); 
    print "LETTERS: " . join(", ", @letters) . "\n"; 
    my ($word, $letters, $score) = find_max_score(@letters); 
    print "$word has a score of $score.\n";
    print "These letters were used: $letters.\n";  
} 
