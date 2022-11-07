# The Weekly Challenge 190
# Task 2 Decoded List
use v5.30.0;
use warnings;
use Algorithm::Combinatorics qw /combinations/;
use List::Util qw/all/;

say join "\n", decode($ARGV[0]) if defined($ARGV[0]) && $ARGV[0] =~ m/\d+/;

sub decode {
    my $c1 = '^[1-9]$';
    my $c2 = '^1[0-9]$';
    my $c3 = '^2[0-6]$';

    my $ciphertext = $_[0];
    my @plaintexts;

    # split the string into bites of ones and twos;
    # using codes from TWC 112 Climb Stairs
    my $n = length $ciphertext;

    my @possibilies;

    for my $i ($n%2+$n/2 .. $n-1) {
        my $iter = combinations([0..$i-1] , ($n-$i) );
        my $str = "1" x $i;
        while (my $c = $iter->next) {
            my $str_clone = $str;
            substr($str_clone, $_, 1) = "2" for (@{$c});
            push @possibilies, $str_clone;
        }
    }
    push @possibilies , "1" x $n;

    foreach my $onetwoseq (@possibilies) {
        my @ABCDE_in_nmrc = divide_string($ciphertext, $onetwoseq);
        next unless all {    $_ =~ m/$c1/ 
                          || $_ =~ m/$c2/
                          || $_ =~ m/$c3/ } @ABCDE_in_nmrc;
        push @plaintexts, join "", map {OneToA($_)} @ABCDE_in_nmrc;
    }
    return @plaintexts;
}

sub divide_string {
    my $text = $_[0];
    my $nums = $_[1];
    my @temp = split "", $text;
    my @digits = split "", $nums;
    my @result;
    my $i = 0;
    for (@digits) {
        my $k = $_;
        my $w = "";
        while ($k != 0) {
            $w .= $temp[$i];
            $i++;
            $k--;
        }
        push @result, $w;
    }
    return @result;
}

sub OneToA {
    return chr( ord('A') - 1 + $_[0] );
}



# checking
say "  11: ", join ", ", decode("11"); # "AA", "K"
say "1115: ", join ", ", decode("1115"); # "AAAE", "AAO", "AKE", "KAE", "KO"
say " 127: ", join ", ", decode("127"); #"ABG", "LG"
