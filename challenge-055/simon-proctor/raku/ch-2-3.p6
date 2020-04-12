#!/usr/bin/env raku

use v6.d;

# Attempt the third
#| Given a list of integers return all the wave sorted lists
multi sub MAIN( *@input where { $_.elems >= 2 && $_.all ~~ Int } ) {
    my $input-channel = Channel.new;
    my $output-channel = Channel.new;
    my $messages = Supplier.new;
    my $reader = $messages.Supply;

    my $count = 0;
    for @input.kv -> $i, $val {
        my @poss = @input[0..^$i,$i^..*-1].flat;
        $input-channel.send( [ [$val], @poss, 'gte' ] );
        $count++;
    }

    await start react {
        whenever $reader -> $change {
            $count += $change;
            if ( $count == 0 ) {
                $input-channel.close;
                $output-channel.close;
                $messages.done;
            }
        }
        whenever $output-channel -> @out {
            @out.join(",").say;
        }
        whenever $input-channel -> ( @i, @p, $t ) {
            find-waves( @i, @p, $t, $input-channel, $output-channel, $messages );
        }
    }
}

# End state
multi sub find-waves( @i, [] where { True }, 'gte', $, $out, $sup ) { $out.send( @i ); $sup.emit(-1); }
multi sub find-waves( @i, [] where { True }, 'lte', $, $out, $sup ) { $out.send( @i ); $sup.emit(-1); }

# Fail States
multi sub find-waves( @i, @p where { @i[*-1] < all(@p) }, 'gte', $, $, $sup ) { $sup.emit(-1); }
multi sub find-waves( @i, @p where { @i[*-1] > all(@p) }, 'lte', $, $, $sup ) { $sup.emit(-1);}

# Possible State
multi sub find-waves( @output is copy, @input is copy, $test, $in, $, $sup ) {
    my @out;

    my &test = $test ~~ 'gte' ?? &infix:«>=» !! &infix:«<=»;
    
    for @input.kv -> $i, $val {
        next unless &test( @output[*-1], $val );
        my @poss = @input[0..^$i,$i^..*-1].flat;
        $sup.emit(1);
        $in.send( [ [|@output, $val], @poss, $test ~~ 'gte' ?? 'lte' !! 'gte' ] );
    }
    $sup.emit(-1);
}
