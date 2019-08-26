# Write a script to print first 10 Sexy Prime Pairs.
# Sexy primes are prime numbers that differ from each other by 6.
# For example, the numbers 5 and 11 are both sexy primes, because 11 - 5 = 6.
# The term “sexy prime” is a pun stemming from the Latin word for six: sex.

#This is my first ever attempt to write a perl6 program. Please go easy on me.
#I will try to do it in a perl6-ish way
#But first;
#print "Hello World!";
#Works!

#Perl6 One-Liner
say grep { $_[1]-$_[0] == 6 }, (grep { $_.is-prime }, 0..55).combinations: 2;

#Perl6 using sieve of eratosthenes
my Int @r = 0..55;
grep {
    if ($_>1) {
        for $_..((@r.end+1)/$_).Int -> $x {
            @r[ $_*$x ] = 0;
        }
    }
}, @r;

grep { $_>1 && (($_+6) ~~ any @r) && say ($_,$_+6) }, @r
