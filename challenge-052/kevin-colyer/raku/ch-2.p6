#!perl6
# Task 2 Challenge 052 Solution by kevincolyer
# Lucky Winner
# Suppose there are following coins arranged on a table in a line 
# in random order.
# £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
# Suppose you are playing against the computer. Player can only 
# pick one coin at a time from either ends. Find out the lucky winner, 
# who has the larger amounts in total?

# alphabeta search?
# simple search with backtracking? (yes as fewest coins)
# heuristic - make opponant pick two back choices
my @line= 100, 50, 1, 10, 5, 20, 200, 2;

my $ticks=0;
# do a recursive alphabeta search, ending at last coin, returning best coin to choose...
sub search($alpha is copy,$beta is copy ,@line is copy) {
    
    # reached bottom of search
    return (@line.head,'l') if @line.elems==1;

    # thinking dots..
    print "." if $ticks %% 100;
    $ticks++;
    
    # search the two ends of the line of coins
    my $coin1 = @line.head;
    my $s1=search($beta,$alpha+$coin1,@line[1..*]);
    my $coin2 = @line.tail;
    my $s2=search($beta,$alpha+$coin2,@line[0..*-2]);

    return $s1[0] < $s2[0] ?? ($coin1,'l') !! ($coin2,'r');
}

#= Coin game. Set --hardness=0 or --hardness=1, 2, 3, etc
sub MAIN(Int :$hardness=0) {
    my $round=0;
    my $you=0;
    my $pc=0;

    if $hardness > 0 {
        for ^$hardness*4 {
            @line.push: (100,200,50,20,10,5,1).pick    
        }
    };

    while @line.elems {
        say "Round $round: Your total: $you, PC's Total $pc \nCoins: --> {@line} <--";
        
        my Str $s = prompt "You: which coin do you pick? (Left {@line.head} or Right {@line.tail}) ";
        my $side=$s.lc.substr(0,1);
        do {say "Error - left or right [$s]\n"; redo} if $side !~~ /l|r/;
        
        my Int $coin;
        $side.lc.substr(0,1) eq 'l' ?? ($coin=@line.shift) !! ($coin=@line.pop); 
        say "\nYou pick $coin";
        $you+=$coin;
        
        # recursive alpha beta search
        print "PC picks...";
        ($coin,$side) = search($pc,$you,@line);
        say " $coin ($side)\n";
        
        $side eq 'l' ?? @line.shift !! @line.pop ;
        $pc+=$coin;
        $round++;
    }

    do {say "Draw"; exit} if $you==$pc;
    say $you>$pc ?? "You Win $you to $pc" !! "PC wins $pc to $you";

}
