#!raku

sub find-solutions( Int :$sum, :@coins ) {
    my @solutions;

    # add all the 'one coin' solutions
    @solutions.push: [ $_ xx ( $sum / $_ ) ] for @coins.grep( $sum %% * );


    # now inspect all the other cases
    for @coins.grep(  $sum !%% * ).sort( { $^b <=> $^a } ) -> $current-coin {
        next if $current-coin > $sum;
        my @current-solution;
        @current-solution.push: $current-coin;

        for @coins.grep( * !~~ $current-coin ).sort( { $^b <=> $^a } ) {
            my $current-sum = [+] @current-solution;
            # try to add the same number over and over again
            while ( ( $current-sum + $_ ) <= $sum ) {
                @current-solution.push: $_ ;
                $current-sum = [+] @current-solution;
            }

            if ( $current-sum == $sum  ) {
                # use a new array to clone it, so I can delete the last value and continue over
                @solutions.push: Array.new: @current-solution.sort;
                @current-solution[ *-1 ]:delete;
                next;
            }
        }

    }


    # last step: decompose every number in a solution into other numbers
    my @decomposed-solutions;
    for @solutions -> @current-solution {
        for 0 ..^ @current-solution.elems -> $switching-index {

            my $current-coin = @current-solution[ $switching-index ];
            next if $current-coin ~~ 1;

            for @coins.grep( $current-coin %% * ) {
                next if $_ ~~ $current-coin;
                my @new-solution = Array.new: @current-solution;
                @new-solution[ $switching-index ]:delete;
                @new-solution[ $switching-index ] = | ( $_ xx ( $current-coin / $_ ) );
                @decomposed-solutions.push: [ @new-solution.sort ];
            }
        }
    }


    # now build something unique
    my %unique-solutions;
    for @decomposed-solutions {
        %unique-solutions{ "{ $_ }" } = $_;
    }

    for @solutions {
        %unique-solutions{ "{ $_ }" } = $_;
    }


    %unique-solutions.values;
}




sub MAIN( Int $S where { $S > 0 },
          *@C where { @C.grep( * ~~ Int ).elems == @C.elems } ) {
    say "Coins are { @C } that must give sum $S";

    my @solutions;

    @solutions = find-solutions( coins => @C, sum => $S );

    @solutions.join( "\n" ).say;

}
