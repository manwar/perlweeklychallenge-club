#!/usr/bin/env perl6

# I wish I would have thought of the "push @a, shift @a; shift @a;" solution.

my @people = 1 .. 50;

while @people > 1 {
    my $last = @people[*-1];

    @people  = @people[@people.keys.grep(* %% 2)];

    shift @people if @people[*-1] == $last;
}

put @people;
