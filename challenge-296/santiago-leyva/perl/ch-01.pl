=begin
You are given a string of alphabetic characters, $chars.

Write a script to compress the string with run-length encoding, as shown in the examples.

A compressed unit can be either a single character or a count followed by a character.

BONUS: Write a decompression function.

Example 1
Input: $chars = "abbc"
Output: "a2bc"
Example 2
Input: $chars = "aaabccc"
Output: "3ab3c"
Example 3
Input: $chars = "abcc"
Output: "ab2c"
=cut

my @inputs = ("abbc","aaabccc","abcc");

foreach(@inputs){
    my $str = $_;
    my $compressed = stringCompress($str);
    print "$str -> $compressed \n";
}

sub stringCompress{
    my $s = shift;

    my %hash = mapString($s);
    my $comp = "";
    my @keys = sort keys %hash;
    foreach(@keys){
        my $value = $hash{$_};
        if($value == 1){
            $comp .= "$_";
        }else{
            $comp .= "$value$_";
        }
    }
    return $comp;
}

sub mapString{
    my $string = shift;
    my @S = split("",$string);
    my %seen;
    foreach(@S){
        if(exists($seen{$_})){
            $seen{$_} += 1;
        }else{
            $seen{$_} = 1;
        }
    }

    return %seen;
}