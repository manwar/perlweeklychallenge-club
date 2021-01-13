#! /opt/local/bin/perl
#
#       tripleplay.pl
#
#         TASK #1
#         3 Sum
#             Given an array @L of integers. Write a script to find all unique
#             triplets such that a + b + c is same as the given target T. Also
#             make sure a <= b <= c.
#
#             Example:
#
#                @L = (-25, -10, -7, -3, 2, 4, 8, 10);
#
#             One such triplet for target 0 i.e. -10 + 2 + 8 = 0.
#
#         method: when dealing with the 3SUM problem, in some way we will need
#             to in the end evaluate all possible combinations of the array for
#             a solution. Trivially, in three nested loops, this can be
#             performed in cubic time. But that explodes pretty quickly, and we
#             can do better; the challenge becomes to get that number down. One
#             way to accomplish this is to refine the search space by better
#             utilizing the information gained when we determine whether a given
#             triplet of values satisfies the conditions. When we evaluate
#             whether
#
#                 a + b + c = T
#
#             we can instead determine whether the result is greater than, less
#             than, or equal to T, and perform different actions based on the
#             cases. For example, if the sum is already too high, no solution
#             will present itself by increasing any of the values, so those
#             possiblities can be immediately determined to fail without further
#             evaluation and we can move on.
#
#             To proactively prune unproductive possibilities*, the input must
#             first be sorted. This will allow us to intelligently adjust the
#             indexes within the input array to grow or shrink the sum until an
#             equality is either reached or found impossible. We fix the "a"
#             variable to the lower end of the array, starting at index 0, and
#             assign "b" and "c" from the indexes of the lower and upper bounds
#             of the remaining range. When testing a given set of indices, if
#             the sum comes out higher than the target, we reduce the index of
#             the upper bound until it points to a lower value for "c". If the
#             sum is lower, we increase the index for "b" until it points to a
#             higher value. If we find an equality, that value of "c" will be
#             the only solution for the given "b", so "b" index is incremented,
#             and the value of "c" will then be too high for a higher value of
#             "b", so it is also decremented. Thus for any given "a" index, the
#             list of elements after it is only iterated through once per
#             element, although the actual movement is sometimes from the lower
#             bound, sometimes from the upper, towards the center.
#
#             When the upper and lower bounds meet, the index for the value for
#             "a" is incremented and the process repeated until either "a", "b",
#             and "c" are set to the last three elements in the input array, or
#             "a" is greater than the target. In this way we have still assessed
#             every possible combination, but eliminated enough logically, to
#             the point where we need not do any computation on them at all, to
#             bring the complexity back into quadratic time.
#
#             Because scalar @list if often referenced yet never changes, we
#             memoize this to save a little computation. It helped enough with
#             the absurdly large test data set I ginned up to glean
#             performance** that I left it in.
#
#             ——————————————————————
#             *  yes, of course that was fun to write
#             ** 100000 random elements between -1000..1000, ~500000 unique
#                solutions. Trying to find the sweet spot between taking a long
#                time and segfaulting.
#
#       2020 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use feature ":5.26";

## ## ## ## ## MAIN:

## 1000 random elements between -9999..10000
my @L;
while (my $line = <DATA>) {
    chomp $line;
    push @L, split /, /, $line;
};

## nominally 0, but this can be changed easily here
my $TARGET  = 0;

my @list    = sort {$a <=> $b} @L;
my $length  = scalar @L;
my @output;

for my $idx ( 0..$length - 2) {

    ## if a, the smallest value, is greater than the target value, no more
    ## solutions are possible and we are done
    last if $list[$idx] > $TARGET;

    ## if a is a duplicate of the previous search, short-circuit to the next value
    next if ($idx > 0 && $list[$idx] == $list[$idx-1]);

    my $a     = $list[$idx];
    my $low   = $idx + 1;
    my $high  = $length - 1;

    while ( $low < $high ) {
        ## if b is a duplicate of the previous search, increment the index and short-circuit
        if ($low > $idx+1  &&  $list[$low] == $list[$low-1]){
            $low++;
            next;
        }
        ## if c is a duplicate of the previous search, decrement the index and short-circuit
        if ($high < $length - 1  &&  $list[$high] == $list[$high+1]) {
            $high--;
            next;
        }
        my $b = $list[$low];
        my $c = $list[$high];

        ## on success note to output, increment the start index and decrement the end
        ## so as not to duplicate searches
        if ($a + $b + $c == $TARGET) {
            push @output, [$a, $b, $c];
            $low++;
            $high--;
        }
        ## if we are already above target shift the end element down and start again
        elsif ($a + $b + $c > $TARGET) {
            $high--;
        }
        ## else try the next internal candidate
        else {
            $low++;
        }
    }
}

say join ', ', $_->@* for @output;

__DATA__
-9971, -9946, -9916, -9903, -9859, -9853, -9840, -9835, -9834, -9817
-9813, -9754, -9737, -9737, -9722, -9688, -9632, -9629, -9601, -9570
-9562, -9533, -9509, -9485, -9459, -9452, -9449, -9444, -9417, -9402
-9379, -9351, -9302, -9275, -9219, -9218, -9216, -9215, -9174, -9156
-9134, -9119, -9115, -9079, -9055, -9040, -9023, -8998, -8998, -8983
-8924, -8909, -8880, -8879, -8854, -8844, -8796, -8742, -8620, -8607
-8585, -8581, -8569, -8558, -8550, -8545, -8533, -8519, -8519, -8470
-8439, -8431, -8405, -8382, -8348, -8323, -8310, -8299, -8233, -8232
-8228, -8226, -8199, -8183, -8128, -8124, -8119, -8117, -8091, -8088
-8082, -8070, -8038, -8020, -8009, -8003, -7990, -7974, -7961, -7929
-7921, -7911, -7894, -7892, -7878, -7852, -7825, -7815, -7810, -7808
-7795, -7768, -7761, -7753, -7704, -7701, -7697, -7688, -7668, -7654
-7642, -7600, -7577, -7563, -7556, -7548, -7546, -7522, -7508, -7468
-7459, -7452, -7449, -7432, -7407, -7406, -7404, -7380, -7332, -7290
-7280, -7237, -7222, -7221, -7220, -7215, -7199, -7190, -7185, -7161
-7137, -7115, -7095, -7092, -7077, -7045, -7023, -7003, -6971, -6950
-6932, -6882, -6876, -6821, -6807, -6804, -6733, -6715, -6711, -6680
-6674, -6658, -6649, -6634, -6615, -6595, -6591, -6555, -6536, -6508
-6491, -6489, -6470, -6464, -6450, -6445, -6420, -6414, -6373, -6363
-6326, -6316, -6201, -6199, -6177, -6134, -6127, -6122, -6114, -6059
-6056, -6054, -6050, -6046, -6026, -6023, -6003, -6000, -5959, -5933
-5897, -5852, -5839, -5817, -5754, -5751, -5748, -5741, -5706, -5705
-5652, -5588, -5572, -5561, -5551, -5524, -5396, -5379, -5358, -5348
-5331, -5328, -5323, -5311, -5233, -5185, -5152, -5148, -5144, -5140
-5120, -5051, -5023, -5014, -5007, -4991, -4984, -4979, -4927, -4914
-4875, -4872, -4850, -4838, -4832, -4832, -4828, -4826, -4820, -4795
-4789, -4782, -4735, -4731, -4730, -4691, -4684, -4680, -4649, -4603
-4575, -4537, -4519, -4510, -4417, -4416, -4411, -4385, -4357, -4334
-4325, -4296, -4213, -4180, -4177, -4150, -4112, -4103, -4042, -4012
-3986, -3966, -3953, -3951, -3937, -3929, -3809, -3777, -3766, -3760
-3758, -3682, -3666, -3664, -3657, -3610, -3606, -3595, -3584, -3565
-3516, -3499, -3488, -3434, -3433, -3413, -3408, -3399, -3374, -3365
-3354, -3346, -3336, -3329, -3281, -3273, -3251, -3241, -3224, -3209
-3199, -3197, -3196, -3173, -3170, -3153, -3144, -3143, -3124, -3096
-3090, -3055, -3052, -3049, -2983, -2973, -2958, -2952, -2899, -2872
-2863, -2860, -2855, -2851, -2782, -2759, -2756, -2693, -2662, -2608
-2608, -2543, -2508, -2499, -2473, -2445, -2433, -2405, -2340, -2293
-2212, -2201, -2198, -2184, -2160, -2156, -2155, -2151, -2141, -2130
-2095, -2086, -2075, -2070, -2066, -2062, -2037, -2035, -2024, -2011
-1988, -1975, -1968, -1957, -1943, -1934, -1933, -1918, -1915, -1913
-1906, -1905, -1893, -1889, -1850, -1829, -1817, -1774, -1749, -1725
-1723, -1678, -1634, -1624, -1619, -1618, -1612, -1569, -1555, -1524
-1523, -1512, -1503, -1495, -1470, -1432, -1402, -1382, -1375, -1300
-1269, -1255, -1223, -1216, -1175, -1169, -1163, -1161, -1158, -1157
-1156, -1121, -1113, -1082, -1075, -1073, -1061, -1055, -1027, -992
-985, -984, -977, -925, -876, -863, -861, -842, -801, -737
-726, -686, -677, -670, -658, -657, -652, -646, -640, -616
-589, -584, -578, -565, -560, -549, -536, -506, -489, -486
-429, -404, -401, -392, -380, -352, -346, -310, -287, -286
-280, -240, -240, -201, -162, -162, -153, -135, -94, -77
-74, -58, -50, -43, 33, 64, 93, 99, 105, 107
136, 152, 159, 165, 176, 214, 230, 277, 290, 313
332, 382, 400, 404, 435, 438, 454, 463, 468, 468
472, 499, 512, 513, 542, 543, 590, 605, 613, 655
690, 702, 741, 763, 790, 796, 826, 840, 891, 909
919, 933, 936, 939, 1000, 1012, 1019, 1030, 1057, 1085
1089, 1101, 1106, 1114, 1115, 1132, 1156, 1179, 1184, 1196
1196, 1203, 1206, 1207, 1229, 1230, 1233, 1237, 1276, 1278
1291, 1303, 1344, 1344, 1373, 1466, 1470, 1526, 1527, 1534
1546, 1550, 1580, 1603, 1621, 1629, 1671, 1708, 1716, 1731
1738, 1742, 1765, 1766, 1779, 1840, 1856, 1870, 1871, 1891
1945, 1951, 1970, 2009, 2014, 2022, 2028, 2038, 2058, 2067
2085, 2105, 2110, 2113, 2117, 2138, 2155, 2168, 2179, 2183
2186, 2228, 2230, 2241, 2261, 2276, 2281, 2394, 2449, 2479
2479, 2482, 2486, 2487, 2501, 2517, 2618, 2668, 2683, 2688
2709, 2724, 2760, 2786, 2790, 2823, 2828, 2879, 2908, 2909
2922, 2947, 3010, 3019, 3045, 3087, 3097, 3162, 3250, 3311
3319, 3332, 3378, 3405, 3416, 3430, 3460, 3496, 3530, 3589
3659, 3661, 3704, 3716, 3725, 3726, 3734, 3771, 3773, 3785
3791, 3812, 3830, 3836, 3884, 3890, 3908, 3912, 3958, 3962
3979, 3985, 3987, 4028, 4033, 4035, 4061, 4062, 4128, 4136
4175, 4194, 4198, 4266, 4271, 4290, 4297, 4321, 4326, 4424
4470, 4489, 4506, 4552, 4559, 4583, 4667, 4715, 4730, 4781
4782, 4784, 4834, 4860, 4879, 4884, 4893, 4909, 4918, 4923
4941, 4993, 5062, 5079, 5106, 5121, 5131, 5160, 5167, 5178
5217, 5245, 5250, 5251, 5260, 5294, 5299, 5339, 5352, 5369
5371, 5376, 5383, 5385, 5402, 5417, 5451, 5472, 5475, 5484
5558, 5558, 5562, 5572, 5573, 5574, 5578, 5580, 5585, 5588
5592, 5631, 5638, 5700, 5702, 5727, 5750, 5772, 5814, 5842
5848, 5852, 5855, 5858, 5897, 5926, 5942, 5975, 5985, 5986
6037, 6050, 6095, 6123, 6130, 6147, 6167, 6183, 6192, 6204
6246, 6263, 6294, 6295, 6301, 6306, 6394, 6433, 6485, 6510
6514, 6516, 6532, 6585, 6623, 6634, 6635, 6661, 6671, 6685
6728, 6729, 6744, 6765, 6780, 6783, 6807, 6808, 6808, 6888
6889, 6914, 6988, 7035, 7040, 7079, 7080, 7087, 7104, 7152
7160, 7160, 7177, 7271, 7322, 7361, 7385, 7402, 7406, 7409
7426, 7428, 7454, 7465, 7470, 7502, 7512, 7627, 7642, 7686
7701, 7703, 7724, 7727, 7748, 7764, 7819, 7843, 7881, 7884
7915, 7932, 7974, 7983, 7988, 8004, 8025, 8032, 8044, 8064
8065, 8086, 8126, 8132, 8133, 8146, 8161, 8177, 8242, 8267
8291, 8344, 8390, 8401, 8416, 8435, 8443, 8449, 8521, 8524
8535, 8545, 8545, 8554, 8560, 8586, 8592, 8596, 8637, 8647
8651, 8675, 8681, 8693, 8714, 8718, 8724, 8740, 8770, 8779
8781, 8786, 8815, 8823, 8837, 8849, 8866, 8888, 8891, 8894
8950, 9007, 9009, 9011, 9034, 9085, 9094, 9117, 9125, 9154
9186, 9195, 9232, 9239, 9253, 9259, 9270, 9295, 9302, 9325
9325, 9326, 9329, 9340, 9369, 9396, 9424, 9455, 9457, 9479
9511, 9514, 9535, 9568, 9591, 9607, 9614, 9617, 9633, 9637
9667, 9681, 9703, 9735, 9737, 9741, 9774, 9774, 9775, 9784
9786, 9818, 9823, 9829, 9851, 9854, 9871, 9912, 9926, 9928
