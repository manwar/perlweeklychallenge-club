#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to generate first 10 Smith Numbers.
According to Wikipedia:
In number theory, a Smith number is a composite number for which, in a given number base, the sum of its digits is equal to the sum of the digits in its prime factorization in the given number base.
=cut









use List::Util qw(sum);
use ntheory qw(is_prime);
use Memoize;
use Mojo::UserAgent;


memoize('sum_of_digits');

my $URL = 'https://oeis.org/A006753/b006753.txt';
my $ua = Mojo::UserAgent->new;
my $res = $ua->get( $URL )->res;
my %SMITH;
do 
{ 
     my ($key, $value) = split(/\s/, $_, 2);
     $SMITH{$key} = $value if ( length($key) > 0 );
} for split(/\n/,$res->dom);

my $number = 2;
my $counter = 1;


while ( $counter < 1_001 ) # 10_001 )
{
     $number++ and next if is_prime($number);

     my $sum_of_digits_of_factors = 
          sum(map sum_of_digits($_), prime_factors($number), 0);



     if ( $sum_of_digits_of_factors == sum_of_digits($number) )
     {
          die "Something wrong with ${number}$/" if $SMITH{$counter} != $number;
          print join(": ", $counter++, $number), $/;
     }
     $number++;
}


sub prime_factors
{
     my $num = $_[0];
     my $half = $num / 2;
     my @factors;

     for my $cand ( 2 .. $half )
     {

          if ( $num % $cand == 0 )
          {
               push @factors, $cand;
               $num /= $cand;
               redo;
          }
     }
     return @factors;

}

sub sum_of_digits { return $_[0] < 10 ? $_[0] : sum(split(//,$_[0]));}