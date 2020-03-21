#!/usr/bin/env raku

my $person;
my $computer;

my @coins = <1 2 5 10 20 50 100 200>;

@coins .= pick(8);

my @players = 2.rand.Int ?? <person computer> !! <computer person>;

say @players[0].tc, " goes first";
 
while @coins {
    say @coins;

    if @players[@coins % 2] eq "person" {
        if @coins == 1 { 
            $person += @coins.pop;
        }

        else {
            my $input = (prompt "Enter L or R ").uc;

            given $input {
                when "R" { $person += @coins.pop   }
                when "L" { $person += @coins.shift }
            }
        }
    }

    else {
        my $index = @coins.antipairs.max.value;

        given $index {
            when 0              { $computer += @coins.shift }
            when @coins.end     { $computer += @coins.pop   }
            when 1              { $computer += @coins.pop   }
            when @coins.end - 1 { $computer += @coins.shift }
            default             { $computer += @coins.pop   } 
        }
    }
}

say "person:   $person";
say "computer: $computer";
