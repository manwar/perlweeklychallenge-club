my @coins = @*ARGS.elems > 0 ?? @*ARGS !! (100, 50, 1, 10, 5, 20, 200, 2);

say @coins;
my ($index200) = grep { @coins[$_] == 200}, 0..@coins.end;
my @before = @coins[0..$index200-1];
my @after = @coins[$index200+1..@coins.end];
loop  {
    my $move = ask();
    last if $move eq "";
    my $coin;
    if ($move eq "B") {
        $coin = @before.elems ?? shift @before !! 200;
    } elsif ($move eq "E") {
        $coin = @after.elems ?? pop @after !! 200;
    } else {
        say "Invalid choice"; next;
    }
    if ($coin == 200) {
        say "You win!"; last;
    }
    if (@before.elems == 0) {
        say "I pick the 200p coin at start and win"; last;
    } elsif (@after.elems == 0) {
        say "I pick the 200p coin at end and win"; last;
    }
    if (@before %% 2) {
        $coin = shift @before;
    } elsif (@after %% 2) {
        $coin = pop @after;
    } else {
        # no winning move, let's hope for a mistake
        if (@before.elems > @after.elems) {
            $coin = shift @before;
        } else {
            $coin = pop @after;
        }
    }
}

sub ask () {
    say "New situation = @before[] 200 @after[]";
    my $choice = prompt "Pick a coin at beginning (B) or end (E) ";
}
