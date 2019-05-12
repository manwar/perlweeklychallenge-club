unit module ModuleCH01;

=begin comment
Challenge 007#1

Print all the niven numbers from 0 to 50 inclusive, each on their own line. A
niven number is a non-negative number that is divisible by the sum of its
digits.
=end comment

multi is-niven( 0 --> False) is export { }
multi is-niven( Int:D $num where * > 0 ) is export {
    $num %% $num.comb.sum;
}
