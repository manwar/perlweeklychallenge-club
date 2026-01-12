use v5.38;

sub proc($results) {
    say "Input: \$results = $results";

    # Results of each round
    my $first = substr $results, 0, 3;
    my $second = substr $results, 3, 2;
    my $third = substr $results, 5, 1;

    # Outcomes of round one
    my @outcome;		
    my $winner = substr($first, 0, 1);
    push @outcome, ($winner eq "H") ? 2 : 7;
    $winner = substr($first, 1, 1);
    push @outcome, ($winner eq "H") ? 3 : 6;
    $winner = substr($first, 2, 1);
    push @outcome, ($winner eq "H") ? 4 : 5;
    
    # Match-ups in round two (Home team, Away team)
    my @one = (1, $outcome[1]);
    my @two = sort { $a <=> $b } ($outcome[0], $outcome[2]);

    my @outcome2;
    # Outcomes of round two
    $winner = substr($second, 0, 1);
    push @outcome2, ($winner eq "H") ? $one[0] : $one[1];
    $winner = substr($second, 1, 1);
    push @outcome2, ($winner eq "H") ? $two[0] : $two[1];

    # Last round
    @outcome2 = sort { $a <=> $b } @outcome2;
    print "Output: Team $outcome2[0] hosts team $outcome2[1], and team ";
    if ($third eq "H") {
	print "$outcome2[0]";
    } else {
	print "$outcome2[1]";
    }
    say " is the winner.";
    
}

my $results = "HAHAHH";
proc($results);
$results = "HHHHHH";
proc($results);
$results = "HHHAHA";
proc($results);
$results = "HAHAAH";
proc($results);
$results = "HAAHAA";
proc($results);
