#!/usr/bin/perl
use 5.030;
use warnings;
use experimental qw/ switch /;
use English;

sub usage {
print STDERR <<"-END-";
Usage:
  $PROGRAM_NAME <arg1> <op> <arg2>
  
    <arg1>    Number in Roman numerals
    <op>      Arithmetic operation (+, -, *, / or **)
    <arg2>    Number in Roman numerals
-END-
    exit(1);
}

sub unprefix {
    my ($num) = @_;

    my @from = qw/ CM    CD   XC    XL   IX    IV   /;
    my @roman =   qw/ DCCCC CCCC LXXXX XXXX VIIII IIII /;

    for my $i (0 .. scalar @from - 1) {
        $num =~ s/$from[$i]/$roman[$i]/g;
    }

    return $num;
}

sub normalize {
    my ($num) = @_;
    my @from = qw/ IIIII IIII VV VIV XXXXX XXXX LL LXL CCCCC CCCC DD DCD /;
    my @roman =   qw/ V     IV   X  IX  L     XL   C  XC  D     CD   M  CM  /;

    for my $i (0 .. scalar @from - 1) {
        $num =~ s/$from[$i]/$roman[$i]/g;
    }

    return $num;
}

sub toEnglish {
    my ($num) = @_;
    my %values = (
        'M' => 1000,
        'D' => 500,
        'C' => 100,
        'L' => 50,
        'X' => 10,
        'V' => 5,
        'I' => 1,
    );

    my $english = 0;

    for my $digit (split //, unprefix($num))  {
        $english += $values{$digit};
    }

    return $english;
}

sub toRoman {
    my ($num) = @_; 
    my $roman;

    while ($num > 0) {
        if ($num >= 1000) {
            $roman .= 'M';
            $num -= 1000;
        }
        elsif ($num >= 500) {
            $roman .= 'D';
            $num -= 500;
        }
        elsif ($num >= 100) {
            $roman .= 'C';
            $num -= 100;
        }
        elsif ($num >= 50) {
            $roman .= 'L';
            $num -= 50;
        }
        elsif ($num >= 10) {
            $roman .= 'X';
            $num -= 10;
        }
        elsif ($num >= 5) {
            $roman .= 'V';
            $num -= 5;
        }
        elsif ($num >= 1) {
            $roman .= 'I';
            $num -= 1;
        }
    }

    return normalize($roman);
}


if (scalar @ARGV != 3) {
    usage();
}

my ($arg1, $op, $arg2) = @ARGV;

my $val;
my $eng1 = toEnglish($arg1);
my $eng2 = toEnglish($arg2);

given ($op) {
    when ('+')  { $val = $eng1 + $eng2; }
    when ('-')  { $val = $eng1 - $eng2; }
    when ('*')  { $val = $eng1 * $eng2; }
    when ('/')  { $val = $eng1 / $eng2; }
    when ('**') { $val = $eng1 ** $eng2; }
    default     {  usage; }
}

given ($val) {
    when ($_ == 0)      { say 'nulla'; }
    when ($_ != int)    { say 'non potest'; }
    when ($_ <= 0)      { say 'non potest'; }
    when ($_ >= 4000)   { say 'non potest'; }
    default             { say toRoman($val); }
}
