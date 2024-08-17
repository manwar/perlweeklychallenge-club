#!/bin/perl -w


# Task 2: Knight’s Move
# Submitted by: Peter Campbell Smith
# A Knight in chess can move from its current position to any square two rows or columns plus one column or row away. So in the diagram below, if it starts a S, it can move to any of the squares marked E.

# Write a script which takes a starting position and an ending position and calculates the least number of moves required.

# Week_281_Task_2

# Example 1
# Input: $start = 'g2', $end = 'a8'
# Ouput: 4

# g2 -> e3 -> d5 -> c7 -> a8
# Example 2
# Input: $start = 'g2', $end = 'h2'
# Ouput: 3

# g2 -> e3 -> f1 -> h2


testMe(\&process, 'Example1', "g2", "a8", 4);
testMe(\&process, 'Example2', "g2", "h2", 3);
testMe(\&process, 'Example3', "g2", "g2", 0);
testMe(\&process, 'Example4', "g2", "f4", 1);

sub testMe {
    my $processor = shift;
    my $name = shift;
    my $input1 = shift;
    my $input2 = shift;
    my $expectedValue = shift;

    my $got = &$processor($input1, $input2);

    if ( $got == $expectedValue ) {
        print "[OK ] $name\n";
    }
    else {
        print "[ERR] $name :: got=$got, expectedValue=$expectedValue\n";
    }

}

sub process {
    my $start = shift;
    my $end   = shift;


    my $startPos = parse($start);
    my $endPos = parse($end);

    # print("start=$start (@$startPos) end=$end (@$endPos)\n");

    my $context = {
        alreadyVisited => { toText($startPos) => 1},
        shortestSolution => undef,
    };


    doMove(0, $context, undef, $startPos, $endPos);

    # print "process called with startPos=" . toText($startPos) . " and endPos=" . toText($endPos) . 
    #    ", shortestSolution=" . toTextList($context->{'shortestSolution'}) .     
    #    "\n";

    if ( not defined $context->{'shortestSolution'} ) {
        return -1;
    }

    return scalar @{$context->{'shortestSolution'}};

}


sub doMove {
    my $index = shift;
    my $context = shift;
    my $currentSolution = shift || [];
    my $currentPos = shift;
    my $endPos = shift;

    if ( defined $context->{'shortestSolution'} ) {

        my $bestLen = scalar @{$context->{'shortestSolution'}};
        my $thisSolutionLen = scalar @$currentSolution;

        if ( $thisSolutionLen >= $bestLen ) {
            # stop processing as early as possible
            return;
        }
    }

    # print "#$index - doMove called with currentPos=" . toText($currentPos) . " and endPos=" . toText($endPos) . 
    #    ", currentSolution=" . toTextList($currentSolution) . 
    #    ", alreadyVisited=" . join(',', keys(%{$context->{'alreadyVisited'}})) . 
    #    "\n";

    if ( areEquals($currentPos, $endPos) ) {
        $context->{'shortestSolution'} = [ @$currentSolution ];
        return;
    }


    my $validMoves = findValidMoves($currentPos);
    #print "from " . toText($currentPos) . " valid moves are: " . toTextList($validMoves) . "\n";

    foreach my $validMove ( @$validMoves ) {

        my $thisMoveText = toText($validMove);

        if ( exists $context->{'alreadyVisited'}->{$thisMoveText} ) {
            # already visited...
            next;
        }
        else {
            $context->{'alreadyVisited'}->{$thisMoveText} = 1;
            push(@$currentSolution, $validMove);
    
            doMove($index+1, $context, $currentSolution, $validMove, $endPos);

            pop(@$currentSolution);  
            delete $context->{'alreadyVisited'}->{$thisMoveText};

        }

    }
}


sub findValidMoves {
    my $pos = shift;

    #print "findValidMoves called from pos=" . toText($pos) . "\n";

    my @validList;
    
    my $addIfValid = sub {
        my $a = shift;

        if ( 
            $a->[0]<1 || $a->[0]>8 ||
            $a->[1]<1 || $a->[1]>8 
        ) {
            return;
        }

        push(@validList, $a);
    };

    $addIfValid->([$pos->[0]+2, $pos->[1]-1]);
    $addIfValid->([$pos->[0]+2, $pos->[1]+1]);
    $addIfValid->([$pos->[0]-2, $pos->[1]-1]);
    $addIfValid->([$pos->[0]-2, $pos->[1]+1]);

    $addIfValid->([$pos->[0]+1, $pos->[1]-2]);
    $addIfValid->([$pos->[0]+1, $pos->[1]+2]);
    $addIfValid->([$pos->[0]-1, $pos->[1]-2]);
    $addIfValid->([$pos->[0]-1, $pos->[1]+2]);

    return \@validList;
}


sub toText {
    my $a = shift;

    if ( not defined $a ) {
        return '<undef>';
    }

    return intToChar($a->[0]) . $a->[1];
}

sub toTextList {
    my $list = shift;

    if ( not defined $list ) {
        return '<undef>';
    }

    return '[' . join(',', map { toText($_) } @$list ) . ']';
}


sub areEquals {
    my ($a, $b) = @_;

    return $a->[0]==$b->[0] && $a->[1]==$b->[1];
}

sub parse {
    my $textNotation = shift;

    if ( $textNotation !~ /([a-h])([1-8])/i ) {
        die "Unexpected textNotation=$textNotation";
    }

    my ($a,$b) = ( charToInt($1), int($2));

    return [ $a, $b ];

}

sub charToInt {
    my $v = shift;

    if ( not defined $v ) {
        return '<undef>';
    }

    #print "got v=$v\n";

    return ord( uc($v) )  - ord('A') + 1;
}

sub intToChar {
    my $v = shift;

    return chr( ord('a') + $v - 1 );
}