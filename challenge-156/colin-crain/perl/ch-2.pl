#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       wiggling-weirdness.pl
#
#       worrisome?

#       wonderous?  

#       wacky?
# 
#       Weird Number
#         Submitted by: Mohammad S Anwar
#         You are given number, $n > 0.
# 
#         Write a script to find out if the given number is a Weird Number.
# 
#         According to Wikipedia, it is defined as:
# 
#         The sum of the proper divisors (divisors including 1 but not itself) of the
#         number is greater than the number, but no subset of those divisors sums to
#         the number itself.
# 
#         Example 1:
#             Input: $n = 12
#             Output: 0
# 
#         Since the proper divisors of 12 are 1, 2, 3, 4, and 6, which sum to 16; but
#         2 + 4 + 6 = 12.
# 
#         Example 2:
#             Input: $n = 70
#             Output: 1
# 
#         As the proper divisors of 70 are 1, 2, 5, 7, 10, 14, and 35; these sum to
#         74, but no subset of these sums to 70.
# 
#         analysis:
# 
#             If weird numbers were common, I suppose the reasoning is,
#             then they wouldn't be very weird, now would they? Well
#             frankly my own life experience directly and daily contradicts
#             this by inspection. Maybe other people's lives are boring and
#             uneventful, but I wouldn't know — and don't have any reason
#             to believe the weird stops at my door.
# 
#             The world, I like to say, is not only weirder than you
#             imagine, but is weirder than you can imagine.
# 
#             A number that is equal to the sum of its proper divisors is
#             known as a perfect number. A number that can be formed from a
#             subset of its proper divisors is not-quite perfect, and is
#             known as a semiperfect number.
# 
#             A number whose proper divisors add to a sum greater than the
#             original number is known as an abundant number. Putting this
#             together it follows that semiperfect numbers are abundant, as
#             there must be some factor left over from constructing the
#             qualifying subset that makes a number semiperfect instead of
#             perfect.
# 
#             The weird numbers are abundant, meaning there are enough
#             factors to sum to the number, but also no combination of
#             those factors can be assembled to do the job, and so are not
#             semiperfect.
# 
#             This combination is rather unusual, to say the least. 
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';



my $count = shift @ARGV // 10;
my $candidate = 0;
my @weird;

while ( @weird < $count and  ++$candidate ) {
    my @pd = proper_divisors( $candidate, 1 );

    push @weird, $candidate 
        if abundant($candidate, @pd) and not semiperfect($candidate, @pd);
}

say "@weird";


sub proper_divisors ($num, $sort = 1) {
    my @pd = 1;
    
    for (2..sqrt $num) {
        next if $num % $_;
        push @pd, ( $num/$_ , $_);    
    }
    return sort {$b<=>$a} @pd if $sort;
    return @pd;
}

sub abundant ( $num, @pdiv ) {
    my $sum = 0;
    $sum += $_ for @pdiv;
    $sum > $num 
        ? 1
        : 0
}

sub semiperfect ( $num, @pdiv ) {
    my $found = 0; 
    my $search_factors = sub ( $num, $total, @facs ) {
        $found = 1 if $total == $num;
        return if $found == 1;
        return if $total > $num;
        return if @facs == 0;
        
        my $factor = shift @facs;
    
        ## take option
        __SUB__->( $num, $total+$factor, 
                            grep { $total+$factor+$_ <= $num } @facs);
        ## pass option
        __SUB__->( $num, $total, @facs)
    } ;
    
    $search_factors->( $num, 0, @pdiv );
    return $found;
}











