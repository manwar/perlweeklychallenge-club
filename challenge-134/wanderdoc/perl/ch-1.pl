#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script to generate first 5 Pandigital Numbers in base 10.
As per the wikipedia, it says: A pandigital number is an integer that in a given base has among its significant digits each digit used in the base at least once.
=cut










use Algorithm::Combinatorics qw(permutations);

use Mojo::UserAgent;
my $ua = Mojo::UserAgent->new;
my $dom = $ua->get( 'https://oeis.org/A050278/list' )->res->dom;

my ($header) = $dom->find('h2')->each;

my @numbers;
$header->next->find('tr td tt')->each(sub { push @numbers, $_->text; });
my %lookup = @numbers;
@numbers = ();

my $first = 1023456789;
my $how_many = my $how_many_copy = shift // 5;

my $last_digits = 1;

# Simple "reverse factorial" to find the necessary number of digits from the right.
my $divisor = 2;


while ($how_many_copy > 1)
{
     $how_many_copy /= $divisor;
     $last_digits++; 
     $divisor++;
}



my $length = length($first);
my $counter = 1;

my $diff = $length - $last_digits;
my ($constant, $variable) = unpack "A${diff}A${last_digits}", $first;

my $template = "A1" x $last_digits;
my @arr = unpack $template, $variable;

my $iter = permutations(\@arr);
while (my $p = $iter->next)
{
     my $candidate = join('',$constant, @$p);
     if ( $counter < 22 )
     {
          die "Something wrong!$/" if ( $lookup{$counter} != $candidate );
     }

     print join(":\t", $counter++, $candidate), $/;
     last if $counter > $how_many;
}