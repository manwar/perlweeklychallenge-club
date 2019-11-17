#! /opt/local/bin/perl
#
#       deli_slicer.pl
#
#       PWC 34 - Task #1
#       Write a program that demonstrates using hash slices and/or array
#       slices.
#
#       In Perl, from the beginning, it has always been noted that "there is
#       more than one way to do it". As such, I have seen through the years
#       how programmers have a tendency to find their personal style -- tools
#       and idioms that work for them -- and then apply them again and again
#       to solve the specific problem of the moment. This is all well and
#       good, but the fact of the matter is that whatever one is doing,
#       there's probably a different way to go about it to get the job done.
#
#       Hash slices allow accessing the values of subsets of keys for a hash,
#       returning lists of results. As of 5.20 lists of alternating key value
#       pairs can be returned, should you want that. In this mass translation
#       of list data they much resemble the map function. Now I like lists,
#       and working with list data operators like map and grep, so I can see
#       the use of this. However one most interesting case I have found is using
#       slices as lvalues, allowing bulk assignment to a hash in a nice
#       succinct manner. For generated hashes this can be very quick, powerful
#       and clean.
#
#       So lets make a toy program. Say we want a to make a cypher, or a puzzle
#       perhaps, based on assignment of numbers to letters. To make things
#       interesting we'll assign a list of primes to letters, then we can take
#       groups of letters and multiply them to produce a new number. After
#       the fact we can reconstruct the letters that made up the original word
#       by prime factorization. It's a toy, so we won't worry too much about
#       why we might want to do such a thing, but it's neat. What we need is a
#       hash, with letters of the alphabet mapped to sequential primes.
#
#       From a previous challenge we constructed a prime number generator that
#       produces a requested number of primes starting at 2. We'll take this
#       subroutine and transplant it whole; it returns a list of primes on the
#       stack. For our toy decoder, we will borrow two more prime-related
#       subroutines: decompose(), which reduces a number into its prime
#       factors, and its dependency make_primes().
#
#       We can now generate the required hash in one simple line:
#
#           @hash{ ( 'a'..'z' ) } = make_primes(26);
#
#       which is rather ridiculously easy. As part of an encoding function, we
#       use another slice:
#
#           @lookup{ split //, lc($word) }
#
#       which takes the input phrase, chops it up into a list of letters, and
#       returns a list of looked-up prime values for those component letters.
#       In the decoding function we use a third slice:
#
#           @reverse_lookup{ decompose($code_number) }
#
#       which takes the list of primes returned by decompose() and produces a
#       list of the corresponding letter values.
#
#       So here we have three examples of the use of hash slices for list-wise
#       data transformation, in this case each is fed not by a fixed list, but
#       rather by a generated list returned by a function or subroutine; the
#       slice syntax produces in turn a list of corresponding hash values.
#       Displaying the transformation process shows the component letters of the
#       words have lost their placement order but have been preserved. As the
#       purpose here is to demonstrate the use of hash slices as list
#       transformation tools, we'll leave it at that. Figuring out a way to save
#       and reconstruct the letter order can be left as an exercise for the
#       reader, or at least another time.
#
#
#       2019 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

use List::Util qw(product);

## ## ## ## ## MAIN

my %lookup;

## here we do bulk assignment to the hash from the list returned by a subroutine
@lookup{ ( 'a'..'z' ) } = make_primes(26);

## output to demonstrate the key/value pairs produced
say "the generated lookup hash:\n";
for (sort keys %lookup){
    printf "\t%s => %-d\n", $_, $lookup{$_};
}

## create a reverse_lookup lookup hash. We know the values are unique, being prime and all
my %reverse_lookup = reverse %lookup;


## toy test
my $phrase = 'The quick brown fox jumped over the lazy dog';

## first we encode the letters into primes and multiply them, using the List::Util::product function
my (@encoded, @decoded);
for my $word ( split /\s/, $phrase ) {
    push @encoded, product( @lookup{ split //, lc($word) } );
}
## then we decode the array of products back into their constituant letters
for my $code_number ( @encoded ) {
    push @decoded, join '', ( @reverse_lookup{ decompose($code_number) });
}

## display the process
say '';
printf " phrase:   %s\n", $phrase;
printf "encoded:   %s\n", (join " ", @encoded);
printf "decoded:   %s\n", (join " ", @decoded);



## ## ## ## ## SUBS

sub make_primes {
## returns a list of as many primes as you ask it for
    my $num_primes = shift;
    my $count = 0;
    my @output = (2);
    my $is_prime;
    for(  my $candidate = 3;  $count <= ($num_primes - 2);  $candidate += 2  ) {
        my $sqrt_candidate = sqrt( $candidate );
        $is_prime = 1;
        for(  my $test = 3; ( $test <= $sqrt_candidate ) && ( $is_prime==1 ); $test += 2  ) {
            if(  $candidate % $test == 0  ) {
                $is_prime = 0;
            }
        }
        if(  $is_prime == 1  ) {
            push @output, $candidate;
            $count++;
        }
    }
    return @output;
}

sub decompose {
## given a number,
## returns an array list of prime decomposition factors of the number
    my $num = shift;
    my @decomp;
    my $prime = 2;
    my $primelist = [$prime];

    while ( $prime <= $num ) {
        while ($num % $prime == 0) {
            $num = $num / $prime;
            push @decomp, $prime;
        }
        $prime = get_next_prime($primelist);
    }
    return @decomp;

}

sub get_next_prime {
    ## given a listref of all primes up until a certain point,
    ## adds next prime to the list and returns the prime

    my $primelist = shift;

    ## assign the last prime recorded + 1 as the new candidate
    my $candidate = $primelist->[scalar $primelist->@* - 1] + 1;

    ## index through the prime list checking for divisability; if found augment and restart the test.
    ## if the test value exceeds the squareroot of the candidate, the candidate
    ## is prime. Put it on the list and return the candidate.
    ## yes it's an infinite loop but there will always be another prime, right?
    ## ...
    ## right?
    for (my $i = 0; my $test = $primelist->[$i]; $i++) {
        my $root = int(sqrt($candidate));
        if ($test > $root) {
            push $primelist->@*, $candidate;
            return $candidate;
        }

        if ($candidate % $test == 0) {
            $i = -1;
            $candidate++;
            next;
        }
    }
}
