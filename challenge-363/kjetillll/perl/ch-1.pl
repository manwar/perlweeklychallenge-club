my($true,$false)=(1,0);

sub f {
    my($str, $claim_v, $claim_c) =
        shift() =~ /^(\w+) .*? (\w+) vowel.* (\w+) consonant/;

    my %num; @num{qw(zero one two three four five six)} = 0..6; #Lingua::EN::Numbers::num2en() for more
    
    my $v = $str=~s/[aeiouy]//g;
    my $c = $str=~s/[a-z]//g;
    
    $v == $num{$claim_v}  &&  $c == $num{$claim_c} ? $true : $false;
}

print f($$_[0]) == $$_[1] ? "ok\n" : "ERROR\n" for
[ "aa — two vowels and zero consonants"     => $true],
[ "iv — one vowel and one consonant"        => $true],
[ "hello - three vowels and two consonants" => $false],
[ "aeiou — five vowels and zero consonants" => $true],
[ "aei — three vowels and zero consonants"  => $true],
[ "aeix — three vowels and zero consonants" => $false],
