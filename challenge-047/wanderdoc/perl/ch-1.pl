#!perl
use strict;
use warnings FATAL => qw(all);

=prompt
Write a script that accepts two roman numbers and operation. It should then perform the operation on the give roman numbers and print the result.
For example, perl ch-1.pl V + VI should print XI.
=cut


use List::Util qw(sum); 



# Some basic data.

my %romans = (I => 1, V => 5, X => 10, 
              L => 50, C => 100, D => 500, 
              M => 1000);
my %arabic = reverse %romans;

my %expand = ('I~V' => 'I', 'V~X' => 'I', 'X~L' => 'X', 'L~C' => 'X', 'C~D' => 'C', 'D~M' => 'C',
              'M~M'=> 'M');
my %before;
for my $key ( sort { $romans{$expand{$a}} <=> $romans{$expand{$b}} } keys %expand )
{
     my ($left, $right) = split(/~/, $key);
     $before{ $right } = $expand{$key} if not exists $before{ $right };
     $before{ $left }  = $expand{$key} if not exists $before{ $left }; 
}
# Roman numerals regex - e.g. here: https://stackoverflow.com/questions/267399
my $rom_re = qr/^M{0,3}(?:C[MD]|D?C{0,3})(?:X[CL]|L?X{0,3})(?:I[XV]|V?I{0,3})$/;
my $re_opr = qr#^(?:[+-/]|\*{1,2})$#;

# Input Validation.

die "Usage <NUM> <+-*/> <NUM>" unless 3 == @ARGV;
my ($op_1, $opr, $op_2) = @ARGV;


for ( $op_1, $op_2 )
{
     die "$_ is invalide Roman numeral!" if $op_1 !~ /$rom_re/;
}
die "$opr is invalide operator!" if $opr !~ /$re_opr/;




# Dispatch table for calculations, learned from choroba.
my %calc = 
(
     '+' => sub { return $_[0] + $_[1]; },

     '-' => sub { return $_[0] - $_[1]; },

     '*' => sub { return $_[0] * $_[1]; },

     '/' => sub { # Well, there is no 0 in Roman numerals :-)
                  return "ERROR: Division by zero!" if 0 == $_[1]; 
                  return int($_[0] / $_[1]); },
     '**' => sub { return $_[0] ** $_[1]; },
);


# Transformation, calculation and back-transformation.

($op_1, $op_2) = map rom2int($_) , ($op_1, $op_2);
my $result = $calc{$opr}->($op_1, $op_2);
$result = int2rom($result);

print $result, $/;


# Subroutines. Way too cumbersome, I think.

sub rom2int
{
     my $str = $_[0];
     $str =~ s/(IV|IX|XL|XC|CD|CM)/'-' . distract($1) . '-'/gex;
     $str =~ s/([^-0-9])/-$1-/g;
     my $num = sum map { $romans{$_} // $_ } grep length($_), split('-',$str);
     return $num; 
}

sub distract
{
     my $str = $_[0];
     my @arr = map $romans{$_}, split(//, $str);
     my $result = $arr[1] - $arr[0];
     return $result;
}


sub int2rom
{
     my $num = $_[0];
     return 'nulla' if 0 == $num;
     return "Out of range" if $num > 3999;
     my $minus = '';
     if ( $num < 0 )
     {
          $minus = "MINUS ";

          $num = abs($num);
     }
     my @arr = split('',$num);
     my $pos = 0;
     @arr = reverse map { $_ *= (10 ** $pos++); } reverse @arr;
     @arr = map convert($arr[$_], ($#arr - $_)), 0 .. $#arr;
     my $str = join('',$minus, @arr);
}



sub convert
{
     my $num = $_[0];
     my $pot = $_[1];
     return '' if 0 == $num;

     if ($arabic{$num}) { return $arabic{$num};}
     my @borders = nearest($num);

     if ( $num > 1_999 ) { @borders = (1_000, 1_000); }
     my @between = map $arabic{$_}, @borders;

     if ( $num =~ /4/ )
     {
          return @between;
     }
     elsif ( $num =~ /9/ )
     {
          $between[0] = $before{$between[1]};
          return @between;
     }
     else
     {
          return $arabic{$borders[0]} . $expand{ join("~",@between) } x (($num - $borders[0])/10**$pot )

     }
     return $num;
}



sub nearest
{
     my $num = $_[0];
     my @arr = sort { $a <=> $b } keys %arabic;
     for my $i ( 0 .. $#arr - 1 )
     {
          if ( $num > $arr[$i] and $num < $arr[$i+1] )
          {
               return @arr[$i, $i+1];
          }
      }
}

# Test.
# use FindBin qw($Bin);
# open my $in, "<", "$Bin/a006968.txt" or die "$!"; # https://oeis.org/A006968/a006968.txt
# while (my $line = <$in>)
# {
     # next if $. < 15;

     # chomp $line;
     # $line =~ tr/ //ds;

     # next if length($line) == 0; # e.g. line 1506.

     # my ( $num, $rom ) = split(/=/, $line);
     # if ( $rom !~ /$rom_re/ ) {print $rom, " not validated", $/; }
     # print join("=>", $num, $rom, rom2int($rom), int2rom($num)), $/  
          # if ( ($num != rom2int($rom)) or ($rom ne int2rom($num)));
# }