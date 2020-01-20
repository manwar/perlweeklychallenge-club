#!env perl6

# Perl Weekly Challenge 44
# Task 2
# You have only $1 left at the start of the week.
# You have been given an opportunity to make it $200. The rule is simple with every move you can either double what
# you have or add another $1. Write a script to help you get $200 with the smallest number of moves.
# See <https://perlweeklychallenge.org/blog/perl-weekly-challenge-044/>
#
# Start with one buck,
#   then double to get 2 $,
#   then add one buck to get 3 $,
#   then double to get 6 $,
#   then double to get 12 $,
#   then double to get 24 $,
#   then add one buck to get 25 $,
#   then double to get 50 $,
#   then double to get 100 $,
#   then double to get 200 $
# You need 9 operations to get from 1 $ to 200 $!


my $initial-value = 1;
my $final-value   = 200;


sub MAIN( Int :$final-value = 200,
          Int :$initial-value = 1 ){
    my $current-val = $final-value;
    my @moves;

    while ( $current-val > $initial-value ) {

        @moves.unshift: '%s to get %d $'
                            .sprintf( $current-val %% 2 ?? 'double' !! 'add one buck', $current-val );
        $current-val = $current-val %% 2 ?? $current-val / 2 !! $current-val - 1;

        # given  $current-val %% 2 {
        #     when .so {
        #         @moves.unshift: 'double to get %d $'.sprintf( $current-val );
        #         $current-val /= 2;
        #     }
        #     when ! .so {
        #         @moves.unshift: 'add one buck to get %d $'.sprintf( $current-val );
        #         $current-val -= 1;
        #     }
        # };
    }

    @moves.unshift: 'Start with one buck';
    @moves.join( ",\n then ").say;
    'You need %d operations to get from %d $ to %d $!'.sprintf( @moves.elems - 1, $initial-value, $final-value ).say;

}

