#! /usr/bin/env raku

# Call as 'raku ch-2.raku --numbers="1,2,3,4,5,6,7"'
# Defaults to "1,2,3,4,5,6,7"
#
# The problme has multiple solutions. It prints all solutions.

sub MAIN(
    Str :$numbers = "1,2,3,4,5,6,7"
){
    my @labels = ["a".."z"];
    my @arr = $numbers.split(/\,/);

    my @solutions = @arr.permutations.grep(
        ->@l
        {
            @l[0] + @l[1]  ==  @l[1] + @l[2] + @l[3]  ==  @l[3] + @l[4] + @l[5]  ==  @l[5] + @l[6];

        });

    for @solutions -> @solution {
        say "Solution: ", @solution;
        for zip(@labels, @solution) -> @pair {
            say "@pair[0] = @pair[1]";
        }
        say "";
        say "Box 1: a + b = @solution[0] + @solution[1] = ", @solution[0] + @solution[1];
        say "Box 2: b + c + d = @solution[1] + @solution[2] + @solution[3] = ", @solution[1] + @solution[2] + @solution[3];
        say "Box 3: d + e + f = @solution[3] + @solution[4] + @solution[5] = ", @solution[3] + @solution[4] + @solution[5];
        say "Box 4: a + b = @solution[5] + @solution[6] = ", @solution[5] + @solution[6];
        say "---------\n";

    }
}
