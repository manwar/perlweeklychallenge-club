#!/usr/bin/perl -s

use v5.16;
use Test2::V0;
use Math::Prime::Util qw(fromdigits todigits todigitstring);
use List::Util qw(all);
use Algorithm::Combinatorics qw(variations);
use Coro::Generator;

use experimental qw(signatures postderef);

our ($examples, $verbose, $base);

$base ||= 10;

run_tests() if $examples;	# does not return

die <<EOS unless @ARGV == 1;
usage: $0 [-examples] [-verbose] [-base=B] [N]

-examples
    run the examples from the challenge
 
-verbose
    print the found number along with its multiples in the given base

-base=B
    use base B

N
    print first N "permuted multiples numbers" in base B
    
EOS


### Input and Output

main: {
    my $permult = gen_perm_mult($base);
    for my $n (map $permult->(), 1 .. shift) {
        last unless $n;
        if ($verbose) {
            # Number and its multiples in given base.
            say join ', ', map todigitstring($n * $_, $base), 1 .. 6;
        } else {
            # Decimal number only.
            say $n;
        }
    }
}


### Implementation

# Additional assumptions:
# - If the multiples shall consist of a permutation of the original
#   number's digits, these digits need to be distinct.  Otherwise the
#   concept of a permutation would not make sense.
# - A leading zero is not permitted.
# Furthermore, there is no need to restrict the task to base 10 or to
# find only the minimum number.
#
# All results for bases 8, 10, 12 and 13 can be found. There are no
# results for other bases below 13.  While base 12 can be handled in
# about 12 min here, base 13 takes about 5 h.
#
# There is an interesting results in base 8: 1234567
#
# For bases up to 12, the leading digit must always be 1.  See below for
# different results in bases 17, 19 and 24.

# Build a generator for "permuted multiples" in the given base.
sub gen_perm_mult ($base) {
    my $done;
    generator {
        # Do not allow the generator to start over.
        yield(undef), return if $done++;
        # The minimum length of such a number cannot be less than six as
        # the number itself and its multiples all have different leading
        # digits if they are of the same length.  The maximum length is
        # the base because all digits shall be distinct.  The
        # $len variable is off by one here as we treat the leading digit
        # separately.
        for my $len (5 .. $base - 1) {
            # There shall be no leading zero and the sixfold of it needs
            # to be below the base.
            for my $ld (1 .. int(($base - 1) / 6)) {
                # Create a hash with all possible digits as keys.
                (\my %digits)->@{0 .. $base - 1} = ();
                # Remove the leading digit.
                delete $digits{$ld};
                # Loop over all variations (a.k.a. k-permutations of n)
                # of digits (except the leading digit) in the given base
                # and in the current length as candidate numbers.
                my $v_it = variations([sort {$a <=> $b} keys %digits], $len);
                while (my $v = $v_it->next()) {
                    # Prepend the leading digit.
                    my @p = ($ld, @$v);
                    # Get the candidate number from the digits in the
                    # given base.
                    my $n = fromdigits \@p, $base;
                    # Check if the digits of all requested multiples of
                    # the candidate number form a permutation of the
                    # candidate number's digits.
                    yield $n
                        if all {isperm(\@p, [todigits $n * $_, $base])} 2..6;
                }
            }
        }
    }
}

# Check if the array @$q is a permutation of @$p.  This is the case if
# all elements of @$p occur in @$q and both arrays have the same length.
sub isperm ($p, $q) {
    return unless @$p == @$q;
    # Create a hash %q having keys from @$q and values 1.
    (\my %q)->@{@$q} = (1) x @$q;
    # Check if all elements of @$p occur in %q.
    @$p == grep $_, @q{@$p};
}


### Examples and tests

sub run_tests {
    is gen_perm_mult(10)->(), 142857, 'task 1';

    done_testing;
    exit;
}

__DATA__

$ time ./ch-1.pl -base=17 -verbose 1
274e9c, 4e9c27, 74e9c2, 9c274e, c274e9, e9c274

real	0m4.088s
user	0m4.072s
sys     0m0.008s

$ time ./ch-1.pl -base=19 -verbose 1
2dag58, 582dag, 82dag5, ag582d, dag582, g582da

real    0m9.522s
user    0m9.488s
sys     0m0.016s

$ time ./ch-1.pl -base=24 -verbose 1
3a6kdh, 6kdh3a, a6kdh3, dh3a6k, h3a6kd, kdh3a6

real    0m52.797s
user    0m52.728s
sys     0m0.008s

$ for base in $(seq 6 13); do echo base: $base; time ./ch-1.pl -verbose -base=$base 1000; echo; done
base: 6

real	0m0.082s
user	0m0.072s
sys	0m0.008s

base: 7

real	0m0.091s
user	0m0.076s
sys	0m0.012s

base: 8
1065432, 2153064, 3240516, 4326150, 5413602, 6501234
1234567, 2471356, 3726145, 5162734, 6417523, 7654312
10765432, 21753064, 32740516, 43726150, 54713602, 65701234
12345670, 24713560, 37261450, 51627340, 64175230, 76543120

real	0m0.160s
user	0m0.152s
sys	0m0.004s

base: 9

real	0m0.736s
user	0m0.732s
sys	0m0.000s

base: 10
142857, 285714, 428571, 571428, 714285, 857142
1428570, 2857140, 4285710, 5714280, 7142850, 8571420
1429857, 2859714, 4289571, 5719428, 7149285, 8579142
14298570, 28597140, 42895710, 57194280, 71492850, 85791420

real	0m6.393s
user	0m6.380s
sys	0m0.008s

base: 11

real	1m4.595s
user	1m4.496s
sys	0m0.012s

base: 12
186a35, 35186a, 5186a3, 6a3518, 86a351, a35186
186a350, 35186a0, 5186a30, 6a35180, 86a3510, a351860
186ba35, 351b86a, 518b6a3, 6a3b518, 86ab351, a35b186
186ba350, 351b86a0, 518b6a30, 6a3b5180, 86ab3510, a35b1860
10a98765432, 2197530a864, 32851a74096, 4372a619508, 5460718293a, 654a3928170
120a9876543, 24197530a86, 362851a7409, 48372a61950, 5a460718293, 7054a392816
123456789ab, 2468b13579a, 36a147b2589, 4915a26b378, 5b4a3928167, 718293a4b56
12345678a9b, 2468b13597a, 36a147b2859, 4915a26b738, 5b4a3928617, 718293a54b6
13579a2468b, 26b3784915a, 3a4b5671829, 51a734962b8, 654312ba987, 789ab123456
197530a8642, 372a6195084, 54a39281706, 7259036a148, 9012345678a, a9876543210
10ba98765432, 21b97530a864, 32b851a74096, 43b72a619508, 54b60718293a, 65b4a3928170
120ba9876543, 241b97530a86, 362b851a7409, 483b72a61950, 5a4b60718293, 705b4a392816
123456789ab0, 2468b13579a0, 36a147b25890, 4915a26b3780, 5b4a39281670, 718293a4b560
12345678a9b0, 2468b13597a0, 36a147b28590, 4915a26b7380, 5b4a39286170, 718293a54b60
13579a02468b, 26b37804915a, 3a4b56071829, 51a7340962b8, 6543120ba987, 789ab0123456
13579a2468b0, 26b3784915a0, 3a4b56718290, 51a734962b80, 654312ba9870, 789ab1234560
13579b02468a, 26b37a049158, 3a4b59071826, 51a7380962b4, 6543170ba982, 789ab6123450
136947a0258b, 271693804b5a, 3a841b607529, 523167409ab8, 659ab3210487, 79483b012a56
136947b0258a, 271693a04b58, 3a841b907526, 523167809ab4, 659ab3710482, 79483b612a50
147a0369258b, 293807164b5a, 41b60a837529, 567412309ab8, 6b32159a0487, 83b019472a56
147a036b2589, 2938071a4b56, 41b60a897523, 567412389ab0, 6b3215a80479, 83b019572a46
147b0369258a, 293a07164b58, 41b90a837526, 567812309ab4, 6b37159a0482, 83b619472a50
147b2589036a, 293a4b560718, 41b975230a86, 56789ab01234, 6b38047915a2, 83b72a461950
1487a036b259, 29538071a4b6, 421b60a89753, 56a7412389b0, 6b73215a8049, 843b019572a6
1487b259036a, 2953a4b60718, 421b97530a86, 56a789b01234, 6b73804915a2, 843b72a61950
15904826b37a, 2b609451a738, 453120789ab6, 5b0168a39274, 7491b50a8632, 8a62413579b0
15904837b26a, 2b609473a518, 453120ab9786, 5b0169278a34, 7491b56380a2, 8a62419b7350
15a26b378049, 2b851a734096, 456789ab0123, 5b4a39268170, 7530a86241b9, 8b13579a0246
15a26b379048, 2b851a736094, 456789ab3120, 5b4a39270168, 7530a86291b4, 8b13579a6240
164b5a392807, 309ab8765412, 472a56b38019, 6179b530a824, 7809536a142b, 9258b1a74036
165b4a392807, 30ba98765412, 475a26b38019, 61b97530a824, 7859036a142b, 92b851a74036
16704b5a3928, 31209ab87654, 47912a56b380, 624179b530a8, 78b209536a14, 936258b1a740
16705b4a3928, 3120ba987654, 47915a26b380, 6241b97530a8, 78b259036a14, 9362b851a740
16a273805b49, 31852740ba96, 48679b015a23, 634a5281b970, 7a31064258b9, 95137a02b846
16a274905b38, 31852960ba74, 4867a23159b0, 634a5701b928, 7a310b925864, 95138462b7a0
16b3805a2749, 31a740b85296, 489b01567a23, 639281b4a570, 7a86425310b9, 957a02b13846
16b4905a2738, 31a960b85274, 48a2315679b0, 639701b4a528, 7a8b92531064, 958462b137a0
17064b5a3928, 32109ab87654, 49172a56b380, 642179b530a8, 7b2809536a14, 963258b1a740
17065b4a3928, 3210ba987654, 49175a26b380, 6421b97530a8, 7b2859036a14, 9632b851a740
18293a4b5607, 3456789ab012, 5083b72a4619, 68b13579a024, 851a7409362b, a147b2589036
18293a4b5706, 3456789ab210, 5083b72a4916, 68b13579a420, 851a74093b26, a147b2589630
18293a54b607, 345678a9b012, 5083b742a619, 68b13597a024, 851a7430962b, a147b2859036
18293a54b706, 345678a9b210, 5083b742a916, 68b13597a420, 851a74309b26, a147b2859630
18293b4a5607, 34567a98b012, 5083ba274619, 68b13975a024, 851a7904362b, a147b8529036
18293b4a5706, 34567a98b210, 5083ba274916, 68b13975a420, 851a79043b26, a147b8529630
19472a5083b6, 369258a147b0, 541987320ba6, 7164b58293a0, 8ab024135796, a83752641b90
19472b6083a5, 36925b01478a, 54198a620b73, 7164ba029358, 8ab029635741, a83759041b26
19483a5072b6, 369478a125b0, 5420b73198a6, 716935824ba0, 8ab574130296, a841b2637590
19483b6072a5, 36947b01258a, 5420ba619873, 71693a024b58, 8ab579630241, a841b9037526
1950842b73a6, 36a1485b2790, 5432108a9b76, 718294ba5360, 8b13592a0746, a86421597b30
1950843b72a6, 36a1487b2590, 543210ba9876, 7182953a4b60, 8b13597a0246, a86421b97530
197530ba8642, 372a61b95084, 54a392b81706, 725903b6a148, 901234b5678a, a98765b43210
1a62b7384095, 3905b274816a, 5768a9b10243, 760ba5294318, 9472a06583b1, b31597a20486
1a62b7395084, 3905b276a148, 5768a9b43210, 760ba5318294, 9472a06b1358, b31597a86420
1a7340962b85, 392681705b4a, 579a02468b13, 76514320ba98, 950483b72a61, b37804915a26
1a7409632b85, 392817065b4a, 57a024698b13, 76543210ba98, 95083b742a61, b38049175a26
1a740b852963, 39281b4a5706, 57a02b138469, 76543a98b210, 95084a621b73, b3805a274916
1a852740b963, 394a5281b706, 58137a02b469, 7698a543b210, 95621084ab73, b4273805a916
1a86420b9753, 3950841b72a6, 5817062b4a39, 76a1483b2590, 95678a4b0123, b432105a9876
1b850962a734, 3b4a17059268, 5b13246879a0, 7a98320b6514, 9a613b725048, ba2649153780
1b8509632a74, 3b4a17065928, 5b13246987a0, 7a983210b654, 9a613b742508, ba2649175380
1b8529630a74, 3b4a57061928, 5b13846927a0, 7a98b2103654, 9a621b734508, ba2749165380
1b9630a85274, 3b706194a528, 5b46928137a0, 7b2103698a54, 9ab734562108, ba9165427380
1b97530a8642, 3b72a6195084, 5b4a39281706, 7b259036a148, 9b012345678a, ba9876543210

real	12m48.420s
user	12m47.296s
sys	0m0.016s

base: 13
12495ba837, 2495ba8371, 3712495ba8, 495ba83712, 5ba8371249, 712495ba83
12495ba8370, 2495ba83710, 3712495ba80, 495ba837120, 5ba83712490, 712495ba830
12495cba837, 2495bca8371, 37124c95ba8, 495bac83712, 5ba83c71249, 71249c5ba83
12495cba8370, 2495bca83710, 37124c95ba80, 495bac837120, 5ba83c712490, 71249c5ba830

real	311m31.056s
user	311m1.516s
sys	0m0.428s
