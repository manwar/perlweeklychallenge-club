#!/usr/bin/env raku

display-cube(2, n-queens 2);


sub display-cube(\n, @queens) {
    my @cube = [[0 xx n] xx n] xx n;
    for @queens -> (\x, \y, \z) {
    	@cube[x][y][z] = 1;
    }
    .say for @cube
}

sub n-queens(\n) {
    my @solutions;
    my @available = ^n X ^n X ^n;
    next-queen( @available, [], @solutions );
    max @solutions
}

sub next-queen( @available, @post, @pre ) {
    @pre.push([@post]) unless @available;
    next-queen @available.grep({.&isn't-attacked: by => $^q}), [|@post, $_], @pre for @available
}

sub isn't-attacked($pos, :by($queen)) {
    my $diff = (@$pos Z- @$queen).unique(as => &abs);
    $diff == 3 or ($diff == 2 and 0 ∉ $diff)
}
