#!perl6
# Task 2 Challenge 052 Solution by kevincolyer
# Lucky Winner
# Suppose there are following coins arranged on a table in a line 
# in random order.
# £1, 50p, 1p, 10p, 5p, 20p, £2, 2p
# Suppose you are playing against the computer. Player can only 
# pick one coin at a time from either ends. Find out the lucky winner, 
# who has the larger amounts in total?


my Int @line= 100, 50, 1, 10, 5, 20, 200, 2;
my Int $ticks=0;

# do a recursive alphabeta search, ending at last coin, returning best coin to choose...
sub search(Int $alpha is copy, Int $beta is copy , Int $lstart is copy, Int $lend is copy, Int $depth is copy) {
    
    # reached bottom of search
    # depth helps prevent search explosion as line of coins increases
    return (@line[$lstart],'l') if $depth==0 || $lstart==$lend;

    # thinking dots..
    print "." if $ticks +& 0x3FF == 0 ;
    $ticks++;
    
    # search the two ends of the line of coins
    my Int $coin1 = @line[$lstart];
    my $s1=search($beta, $alpha+$coin1, $lstart+1, $lend, $depth-1);
    my Int $coin2 = @line[$lend];
    my $s2=search($beta, $alpha+$coin2, $lstart, $lend-1, $depth-1);

    return $s1[0] < $s2[0] ?? ($coin1,'l') !! ($coin2,'r');
}

#= Coin game. Set --hardness=0 or --hardness=1, 2, 3, etc
sub MAIN(Int :$hardness=0, Int :$maxdepth=20) {
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
        $ticks=0;
        ($coin,$side) = search($pc, $you, 0, @line.elems-1, $maxdepth);
        say " $coin ($side) in $ticks searches\n";
        
        $side eq 'l' ?? @line.shift !! @line.pop ;
        $pc+=$coin;
        $round++;
    }

    do {say "Draw"; exit} if $you==$pc;
    say $you>$pc ?? "You Win $you to $pc" !! "PC wins $pc to $you";

}
