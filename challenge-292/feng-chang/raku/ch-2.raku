#!/bin/env raku

unit sub MAIN(Str:D $row, Str:D $hand);

my @balls = $row.comb(/(.)$0*/).map({ [.substr(0, 1), .chars] });
put $_ < Inf ?? $_ !! -1 with zuma(@balls, $hand.comb.Bag, 0);

sub zuma(@balls, %hand, \balls-used --> Any:D) {
    return balls-used if +@balls == 0;
    return Inf if +%hand == 0;

    my $answer = Inf;
    for ^+@balls -> $i {
        my \c = @balls[$i;0];
        next unless %hand{c};

        my %hand_ = %hand.deepmap(*.clone);
        --%hand_{c};
        %hand_{c}:delete unless %hand_{c};

        my @balls_ = @balls.deepmap(*.clone);
        @balls_[$i] = [@balls_[$i;0], @balls_[$i;1] + 1];

        # zuma!!
        if @balls_[$i;1] ≥ 3 {
            my $zuma = True;
            @balls_.splice($i, 1);

            my $j = $i;
            while +@balls_ > 1 and $zuma {
                $zuma = False;
                if $j > 0         and
                   $j < +@balls_  and
                   @balls_[$j-1;0] eq @balls_[$j;0] {
                    with @balls_[$j-1;1] + @balls_[$j;1] -> \length_ {
                        if length_ ≥ 3 {
                            @balls_.splice($j-1, 2);
                            --$j;
                            $zuma = True;
                        } else {
                            @balls_[$j-1] = [@balls_[$j-1;0], length_];
                            @balls_.splice($j, 1);
                        }
                    }
                }
            }
        }

        $answer = min($_, $answer) with zuma(@balls_, %hand_, balls-used + 1);
    }

    $answer
}
