#!usr/bin/perl
use v5.36;

# Challenge 227 - 2 - Roman Maths
# Write a script to handle a 2-term arithmetic operation expressed in Roman numeral.



romanMaths("IV + V      ");     # IX
romanMaths("M - I       ");     # CMXCIX
romanMaths("X / II      ");     # V
romanMaths("XI * VI     ");     # LXVI
romanMaths("VII ** III  ");     # CCCXLIII
romanMaths("V - V       ");     # nulla (they knew about zero but didn't have a symbol)
romanMaths("V / II      ");     # non potest (they didn't do fractions)
romanMaths("MMM + M     ");     # non potest (they only went up to 3999)
romanMaths("V - X       ");     # non potest (they didn't do negative numbers)




sub romanMaths($string)
{

    my $result;
    my ($a, $operator, $b) = $string =~ m/([IVXLCDM]+)\s*([+\-*%\/]\*?)\s*([IVXLCDM]+)/;

    die "Regexp failed at $string"       if not defined $operator;


    if(   $operator eq "+") {   $result = from_roman($a) +  from_roman($b)    }
    elsif($operator eq "-") {   $result = from_roman($a) -  from_roman($b)    }
    elsif($operator eq "*") {   $result = from_roman($a) *  from_roman($b)    }
    elsif($operator eq "**"){   $result = from_roman($a) ** from_roman($b)    }
    elsif($operator eq "/") {   $result = from_roman($a) /  from_roman($b)    }
    else                    {   die "$operator"  if not defined $operator     }

    if($result == 0)
    {
        say "$string =>  Nulla";
    }
    elsif( int($result) != $result or $result > 3999  or  0 > $result)
    {
        say "$string =>  Non potest";
    }
    else
    {
        say "$string =>  " . to_roman($result);
    }


}


# borrowed from
# https://blogs.perl.org/users/laurent_r/2019/05/perl-weekly-challenge-10-roman-numerals-and-jaro-winkler-distance.html



sub from_roman($roman)
{
    state %rom_tab  = (I => 1,  V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000);
    my $numeric     = 0;
    my $prev_letter = "M";

    for my $letter (split //, uc($roman))
    {
        $numeric     -= 2 * $rom_tab{$prev_letter}         if $rom_tab{$letter} > $rom_tab{$prev_letter};
        $numeric     += $rom_tab{$letter};
        $prev_letter  = $letter;
    }
    return $numeric;
}



sub to_roman($arabic)
{
    state %rom_tab  = (I => 1,  V => 5, X => 10, L => 50, C => 100, D => 500, M => 1000);
    my %hash        = %rom_tab;
    my $roman       = "";

    $hash{$_->[0]} = $_->[1]    for (['IV', 4], ['IX', 9], ['XL', 40],  ['XC', 90], ['CD', 400], ['CM', 900] );

    for my $key (sort { $hash{$b} <=> $hash{$a} } keys %hash)
    {
        my $num  = int ($arabic / $hash{$key});
        $roman  .= $key x $num;
        $arabic -= $hash{$key} * $num;
    }
    return $roman;
}

