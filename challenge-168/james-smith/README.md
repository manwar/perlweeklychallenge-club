[< Previous 167](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-167/james-smith) |
[Next 169 >](https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-169/james-smith)

# The Weekly Challenge 168

You can find more information about this weeks, and previous weeks challenges at:

  https://theweeklychallenge.org/

If you are not already doing the challenge - it is a good place to practise your
**perl** or **raku**. If it is not **perl** or **raku** you develop in - you can
submit solutions in whichever language you feel comfortable with.

You can find the solutions here on github at:

https://github.com/drbaggy/perlweeklychallenge-club/tree/master/challenge-168/james-smith

# Challenge 1 - Perrin Prime

***The Perrin sequence is defined to start with [3, 0, 2]; after that, term N is the sum of terms N-2 and N-3. (So it continues 3, 2, 5, 5, 7, ...) A Perrin prime is a number in the Perrin sequence which is also a prime number. Calculate the first 13 Perrin primes***


## Solution

Using our favourite is_prime library we loop through the Perrin numbers and checking to see if they are prime, if they are we display them - if not we restart the loop with `redo`.

Rather than keep the whole array we only need the last 3 numbers in the sequence to generate the next so we have: `$s -> $r`, `$t -> $s` and `$r+$s -> $t`. Once nice feature of perl is that you can do multiple parallel definitions inside a list. The final quirk you see here is `$t!=$` - there is one duplicate value in the list (5) which would mean we saw 5 twice in our output which we don't want....

```perl
my ($r,$s,$t)=(3,0,2);
($r,$s,$t)=($s,$t,$r+$s), is_prime($t) && $t!=$s ? (say $t) : (redo) for 1..13;
```

This gives us the first 13 as: 2; 3; 5; 7; 17; 29; 277; 367; 853; 14,197; 43,721; 1,442,968,193; 792,606,555,396,977.

The prime method is_prime can already handle big integers. So we can extend the range by forcing `$t` to be a big int. As it gets rotated around the other variables they all eventually become big ints.

```perl
my ($r,$s,$t)=(3,0,Math::BigInt->new(2));
($r,$s,$t)=($s,$t,$r+$s), is_prime($t) && $t!=$s ? (say $t) : (redo) for 1..25
```
This gives us the following numbers - the large values may not be correct as
the algorithm does best efforts and doesn't use an exhaustive scan of all
possible factors, the 25th one has 1,111 digits
```
  2
  3
  5
  7
 17
 29
277
367
853
 14,197
 43,721
  1,442,968,193
792,606,555,396,977
187,278,659,180,417,234,321
 66,241,160,488,780,141,071,579,864,797
 22,584,751,787,583,336,797,527,561,822,649,328,254,745,329
 29,918,426,252,927,024,136,988,188,355,201,180,399,482,197
375,650,352,810,749,628,391,658,393,147,651,164,149,079,195,002,314,045,
    738,061,982,119,710,039,976,648,976,965,060,598,469,931,973,177,804,
    611,901,813
 17,889,871,724,792,219,792,241,402,014,701,050,416,254,403,054,909,819,
    082,963,323,121,939,408,639,274,412,767,017,724,313,639,101,409,409,
    795,922,319,558,694,157,739,957
 18,106,564,606,349,058,350,871,445,556,416,183,706,383,627,605,153,862,
    231,876,341,960,946,635,847,221,883,756,661,544,295,450,957,270,512,
    362,655,785,866,338,801,138,896,957,806,303,459,431,839,801
 26,443,665,126,671,039,192,963,010,650,954,408,309,392,693,422,822,076,
    064,578,125,303,560,832,561,672,888,722,088,906,692,033,449,248,344,
    378,194,605,701,099,265,071,815,485,284,432,217,750,405,098,433,434,
    144,179,485,693,746,031,340,517
  1,213,927,704,065,079,865,017,068,478,668,276,043,626,477,148,780,514,
    011,765,015,731,886,286,159,454,983,721,480,068,033,892,046,357,328,
    417,429,372,450,987,777,059,793,416,910,075,913,180,181,245,051,185,
    193,201,551,033,755,831,307,534,780,351,082,477,949,347,441
10,157,009,252,817,374,963,867,100,949,951,608,928,714,862,242,745,008,
    993,013,668,540,854,184,107,874,570,804,968,501,397,570,379,041,274,
    564,782,116,665,400,515,007,185,872,727,535,557,633,044,532,545,504,
    298,417,513,460,010,708,859,590,624,519,737,577,132,699,128,528,530,
    905,048,976,280,744,785,692,707,368,299,964,909,111,445,284,217,209,
    819,026,508,401,682,969,213,029,773,502,708,330,316,828,337,469,827,
    393,737,449,858,748,826,727,773,566,201,071,908,906,567,992,775,961,
    863,663,250,545,199,702,810,339,801,764,180,200,620,104,056,601,639,
    153,965,055,826,816,646,056,412,891,949,330,608,030,933,040,756,303,
    987,388,596,508,709,113,305,229,398,404,925,505,186,056,022,798,817,
    893,091,541,647,706,591,557,044,644,581
  3,631,640,163,992,448,158,050,321,979,101,634,523,424,467,070,532,989,
    940,589,376,200,895,999,542,521,324,121,865,744,873,084,026,078,365,
    592,113,103,829,057,044,319,371,093,458,267,314,150,632,770,247,926,
    037,880,226,504,980,936,257,910,602,481,948,018,841,362,454,143,562,
    440,537,190,514,898,173,776,176,693,598,426,395,086,189,616,722,660,
    098,879,586,330,664,613,823,090,197,360,409,779,437,591,689,520,837,
    492,830,513,163,054,777,061,491,401,259,817,572,546,197,753,109,857,
    199,993,236,881,971,656,255,401,039,799,820,579,630,315,398,215,866,
    349,742,611,432,329,007,353,997,352,494,443,986,017,317,922,833,363,
    523,351,835,711,663,212,252,398,827,126,207,580,953,779,469,798,265,
    218,514,506,497,114,067,477,064,259,789,799,733,135,324,524,166,520,
    280,952,689,291,443,318,735,365,943,242,441,087,374,207,019,201,381,
    566,622,887,361,047,383,284,786,893,087,439,845,660,097,204,995,566,
    088,460,835,424,395,601,898,782,600,822,606,786,314,286,293
  2,219,044,107,563,366,280,125,882,554,584,749,275,765,334,696,920,954,
    707,908,016,835,306,595,717,633,852,868,322,311,975,692,852,664,517,
    100,196,388,216,185,466,256,781,811,629,490,339,018,476,958,341,423,
    474,211,703,736,695,517,844,284,835,529,838,650,317,818,556,051,258,
    418,641,466,473,522,496,581,011,902,709,035,886,778,717,452,108,700,
    155,970,126,389,875,329,986,734,382,348,653,211,376,368,344,688,390,
    461,606,168,880,878,403,666,028,447,970,631,164,159,760,593,687,145,
    545,886,396,290,330,053,367,251,405,062,861,688,751,190,590,145,302,
    902,036,352,069,892,640,867,792,281,047,623,995,380,029,998,885,072,
    389,834,691,845,180,458,330,031,190,164,195,835,720,970,532,382,904,
    375,909,996,290,964,537,793,186,771,320,552,080,008,575,799,336,721,
    259,794,322,290,929,553,980,616,543,051,782,912,060,889,838,405,225,
    710,047,974,384,273,630,158,925,203,871,673,773,377,987,293,309,129,
    339,404,395,731,429,013,268,854,882,845,620,367,126,605,068,300,392,
    529,925,817,814,239,701,362,999,633,802,539,696,168,715,197,247,149,
    129,309,343,328,693,492,609,154,962,326,446,655,316,407,662,545,173,
    312,263,693,868,901,442,507,821,627,007,923,602,173,657,448,415,818,
    836,881,970,741,894,299,422,830,356,726,700,391,358,661,731,817,186,
    882,034,993,006,807,831,454,673,264,747,496,927,244,085,026,523,852,
    798,867,657,837,248,743,977,858,010,507,439,069,833,507,207,554,629,
    542,720,934,827,351,494,206,895,735,690,852,994,106,560,067,899,320,
    290,685,428,051,387,821,434,771,363,835,714,805,717
```

# Challenge 2 - Home Prime

***You are given an integer greater than 1. Write a script to find the home prime of the given number. In number theory, the home prime HP(n) of an integer n greater than 1 is the prime number obtained by repeatedly factoring the increasing concatenation of prime factors including repetitions.***

**Example: **
```
  10 = 2 x  5  ->   25
  25 = 5 x  5  ->   55
  55 = 5 x 11  ->  511
 511 = 7 x 73  ->  773
 773 =    773
```

So `HP(10) = HP(25) = HP(55) = HP(511) = HP(773) = 773`.

## Solution

Our favourite prime libray also has a `factor` function which returns a list of sorted prime factors (including duplicates). This simplfies the problem...

```perl
sub home_prime {
  return if (my$t=shift)<2;
  is_prime($t)?(return$t):($t=join'',factor$t)while 1;
}
```

We first check to see if the parameter passed in is `0` or `1` in which case we return nothing.
Otherwise if the value of the parameter is prime we return that and don't do anything else. o/w
we update it via the rule above and repeat. With the big int support in the prime library we can
compute the home prime for all positive integer between 2 and 100 (with the exception of 49/77
which has yet to be solved!! - they both have the same home prime as `49 = 7x7 -> 77`
