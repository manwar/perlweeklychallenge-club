use v5.38;
my $str = "perl";
proc($str);
$str = "book";
proc($str);
$str = "goodmorning";
proc($str);

sub proc($str) {
    say "Input: \$str = $str";
    my $cnt = grep { $_ =~ /[aeiou]/ } (split "", lc $str);
    say "Output:" , ($cnt % 2 == 0) ? " true" : " false";
}
    
