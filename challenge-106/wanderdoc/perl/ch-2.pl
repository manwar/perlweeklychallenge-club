#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given numerator and denominator i.e. $N and $D. Write a script to convert the fraction into decimal string. If the fractional part is recurring then put it in parenthesis.
Example
Input: $N = 1, $D = 3 Output: "0.(3)"
Input: $N = 1, $D = 2 Output: "0.5"
Input: $N = 5, $D = 66 Output: "0.0(75)"
=cut







use Test::More;

sub long_div
{
     my ($n, $d) = @_;

     die "Division by zero!$/" if $d == 0;

     my $int = int $n / $d;
     my $rest = $n % $d;
     return $int if 0 == $rest;
     my $precision = $d * 3;
     my @output;


     while ( scalar @output < $precision )
     {
          my $temp = $rest * 10; # print "Temp: $temp$/";
          my $dig = int ($temp / $d);
          push @output, $dig;


          $rest = $temp % $d;
          return join('.', $int, join('', @output)) if 0 == $rest;
     }

     my $float = join('', @output); 
     my @repeating = $float =~ /([0-9]+?)(?=\g1+)/g;

     my %rep;

     $rep{$_}++ for @repeating;
     my @keys = sort { $b <=> $a } keys %rep;
     my $group = $keys[0];
     my $group_re = qr/$group/;

     my $head = '';
     if ($float =~ /^([0-9]*?)?${group_re}/ )
     {

          $head = $1;
     }
     return join('.', $int, join('', $head, "(${group})"));
}





is(long_div(1,2), 0.5, '1/2');
is(long_div(1,3), '0.(3)', '1/3');
is(long_div(1,6), '0.1(6)', '1/6');
is(long_div(1,7), '0.(142857)', '1/7');
is(long_div(1,11), '0.(09)', '1/11');

is(long_div(1,19), '0.(052631578947368421)', '1/19');
is(long_div(1,29), '0.(0344827586206896551724137931)', '1/29');

is(long_div(1,46), '0.0(2173913043478260869565)', '1/46');
is(long_div(1,97), '0.(010309278350515463917525773195876288659793814432989690721649484536082474226804123711340206185567)', '1/97');
is(long_div(5,66), '0.0(75)', '5/66');
is(long_div(5,12), '0.41(6)', '5/12');
is(long_div(109,110), '0.9(90)', '109/110');
done_testing;