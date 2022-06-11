#!env perl
use 5.014;
use warnings;

{

    use Math::Prime::Util qw/next_prime is_prime/;
    use List::Util qw/uniq/;
    use Data::Dumper;

    sub get_pn {
        my $what = shift;

        my $last_num = 1;
        my $pn       = 1;
        for ( 1 .. $what ) {
            $last_num = next_prime($last_num);

            $pn *= $last_num;
        }

        return $pn;
    }

    sub find_fortunate_num {
        my $what = shift;

        my $num = 2;
        while ( !is_prime( $what + $num ) ) {
            $num++;
        }

        return $num;
    }

    sub get_n_fortunate_nums {
        my $what = shift;

        my @fortunate_nums;

        # * 2 number should be more than enough
        for ( 1 .. $what * 2 ) {
            my $pn = get_pn($_);

            #print( $pn. "\n" );
            my $fortunate = find_fortunate_num($pn);
            push @fortunate_nums, $fortunate;
        }

        @fortunate_nums = sort { $a <=> $b } uniq(@fortunate_nums);
        @fortunate_nums = @fortunate_nums[ 0 .. $what ];
        return \@fortunate_nums;
    }

    use Test::More;

    is_deeply( get_n_fortunate_nums(7), [ 3, 5, 7, 13, 17, 19, 23, 37 ] );
    done_testing;

}
1;
