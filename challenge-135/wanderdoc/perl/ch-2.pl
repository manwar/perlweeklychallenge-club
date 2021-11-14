#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
You are given 7-characters alphanumeric SEDOL. Write a script to validate the given SEDOL. Print 1 if it is a valid SEDOL otherwise 0. For more information about SEDOL, please checkout the wikipedia page. https://en.wikipedia.org/wiki/SEDOL
=cut











sub validate_SEDOL
{
     my $string = uc $_[0];
     return "Wrong code $string: Vowels are not allowed!$/" if $string =~ /[AEIOU]/;
     my ($code, $check_digit) = unpack "A6A1", $string;

     my $calc_digit = _calculate_cd($code);

     return $calc_digit == $check_digit ? 1 : 0;
}

sub _calculate_cd
{
     my $string = $_[0];
     my @letters = 'A' .. 'Z';
     my %values;
     @values{@letters} = map $_ + 1 + 9, 0 .. $#letters;
     @values{0 .. 9} = 0 .. 9;

     my @weights = (1, 3, 1, 7, 3, 9, 1);


     my @arr = split(//, $string);
     my $sum;


     for my $i ( 0 .. $#arr )
     {
          die "Wrong code!$/" if not exists $values{$arr[$i]};
          $sum += $values{$arr[$i]} * $weights[$i];

     }
     return (10 - $sum % 10) % 10;
}


print validate_SEDOL('2936921'), $/; # 1
print validate_SEDOL('1234567'), $/; # 0
print validate_SEDOL('B0YBKL9'), $/; # 1