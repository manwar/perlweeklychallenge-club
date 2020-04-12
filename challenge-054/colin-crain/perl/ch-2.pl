#! /opt/local/bin/perl
#
#       call_me_collatz.pl
#
#         TASK #2
#         Collatz Conjecture
#             It is thought that the following sequence will always reach 1:
#
#                 $n = $n / 2 when $n is even
#                 $n = 3*$n + 1 when $n is odd

#             For example, if we start at 23, we get the following sequence:
#
#                 23 → 70 → 35 → 106 → 53 → 160 → 80 → 40 → 20 → 10 → 5 → 16 → 8 → 4 → 2 → 1
#
#             Write a function that finds the Collatz sequence for any positive
#             integer. Notice how the sequence itself may go far above the
#             original starting number.
#
#         Extra Credit
#             Have your script calculate the sequence length for all starting
#             numbers up to 1000000 (1e6), and output the starting number and
#             sequence length for the longest 20 sequences.
#
#
#         method: since the conjecture is that _all_ such sequences converge, it
#             seems safe to say that the it's been checked for a lot of numbers.
#             So we'll make a loop that finds the next number, and finishes when
#             that number reaches 1. It may run a while, but it should always
#             eventually finish, right?
#
#             For the sake of clarity, I've removed the logic of the conjecture
#             into its own separate routine.
#
#             For the metaanalysis (hey look, two 'a's in a row, see 53-2),
#             keeping all the sequences for a million numbers gets big quickly,
#             so for that task we throw out the numbers and only keep a total
#             count of the length indexed on the starting number.
#
#             To ensure reproducability, we will slightly modify the challenge
#             to find the lowest numbers of the 20 longest sequences. The
#             request wasn't for the numbers to create sequences of the longest
#             twenty lengths, so we need a qualifier to determine which numbers
#             to include if multiple sequences of equal length are completing
#             for the last places in the list. By sorting first to find the
#             highet values and secondarily to find the lowest number running
#             the script on different systems running different hashing
#             algorithms.
#
#             Since we were in there looking at a couple of million numbers, it
#             seemed reasonable to wonder what the largest number we found was.
#             So I added a little ratcheting variable that updates the high
#             number and the number of the sequence that spawned it whenever the
#             previous value is exceeded. Its 56,991,483,520, in the sequence
#             for the number 704,511. Huh.
#
#             To enable the metaanalysis, pass any positive second argument on
#             the command line.
#
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:
my $start        = shift @ARGV // 23;
my $METAANALYSIS = shift @ARGV // 1;


## get the sequence and print it
say join ', ', make_collatz_sequence($start)->@*;




## metaanalysis section from here down in MAIN
exit unless $METAANALYSIS;
my $data = {  seq_lengths    => {},
              highest_number => 0,
              highest_value  => 0   };

get_collatz_metadata($data);

## display length totals
my $count;
my @sorted = sort { $data->{seq_lengths}->{$b} <=> $data->{seq_lengths}->{$a} || $a <=> $b } keys $data->{seq_lengths}->%*;
say '-' x 35;
say ' count   number   sequence length';
say '-------+--------+------------------';
printf "  %2d     %6d %6d\n", ++$count, $_, $data->{seq_lengths}->{$_} for @sorted[0..19];

## display max number found
say '-' x 35;
say "largest value found was ", $data->{highest_value};
say "for number ", $data->{highest_number};




## ## ## ## ## SUBS:

sub make_collatz_sequence {
## given a positive integer, returns a reference to the array
## of the Collatz sequence associated with it
    my $prev = shift;
    my @seq = ($prev);
    my $next;

    while ($prev != 1) {
        $next = next_collatz($prev);
        push @seq, $next;
        $prev = $next;
    }

    return \@seq;
}

sub next_collatz {
## get the next number according to the rules of the Collatz sequence
    $_[0] % 2 == 0  ?   $_[0] / 2
                    :   3 * $_[0] + 1;
}

sub get_collatz_metadata {
## run metaanalysis on the first 1,000,000 Collatz sequences
    my $data = shift;

    for my $number (1..1000000) {
        my $prev = $number;
        my $len  = 1;
        my $next;

        while ($prev != 1) {
            $next = $prev % 2 == 0  ?   $prev / 2
                                    :   3 * $prev + 1;
            $prev = $next;
            if ($next > $data->{highest_value}) {
                $data->{highest_number} = $number;
                $data->{highest_value}  = $next;
            }
            $len++;
        }
        $data->{seq_lengths}->{$number} = $len;
    }
}
