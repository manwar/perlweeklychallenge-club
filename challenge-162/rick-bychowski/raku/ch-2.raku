#!/usr/bin/env raku
# https://theweeklychallenge.org/blog/perl-weekly-challenge-162/
# https://en.wikipedia.org/wiki/Playfair_cipher

sub MAIN(
    Str  $cmd where {$cmd ~~ /^'encrypt'|'decrypt'$/} = 'encrypt',
    Str :$key = 'Playfair Example',         # can contain non-alpha chars
    Str :$secret = 'Meet me at the Whisky a Go Go', # the text to encrypt or decrypt
    Str :$ij where {$ij.chars > 1}  = 'ij', # the two redundant chars, keep first
    Str :$xq where {$xq.chars > 1} = 'xq'   # padding for double letter or odd secret
) {
    my $i = $ij.comb[0];
    my $j = $ij.comb[1];
    # combine key and alphabet, remove non-alpha, replace i/j
    my $matrix = ($key ~ ('a' .. 'z').join).lc.subst(/<-[a .. z]>/,'', :g).subst(/$j/,$i, :g);
    my @matrix = $matrix.comb.unique.map: -> $a,$b,$c,$d,$e {[$a,$b,$c,$d,$e]};
    my %matrix;  # HoA: keys are letters, values are matrix indices
    loop ( my $m=0; $m < 5; $m++ ) {
        loop ( my $n=0; $n < 5; $n++ ){
            %matrix{"@matrix[$m][$n]"} = [$m,$n];
        }
    }        
    my @result;
    my $plaintext = $secret.lc.subst(/<-[a .. z]>/,'', :g).subst(/$j/,$i, :g);
    $plaintext = $plaintext.chars % 2 == 1 ?? $plaintext ~ $xq.comb.[0] !! $plaintext;
    for $plaintext.comb -> $a, $beta {
        my $b  = $beta; # make copy in case it needs to be substituted
        $b = $a eq $beta ?? $xq.comb.[0] !! $beta; # try subs to 'x'
        $b = $a eq $b    ?? $xq.comb.[1] !! $beta; # 'x' fails, subs to 'q'
        my $am = %matrix{$a}[0];
        my $an = %matrix{$a}[1];
        my $bm = %matrix{$b}[0];
        my $bn = %matrix{$b}[1];
        if $am == $bm {             # same row
            @result.push(@matrix[$am][($an + 1) % 5]) if $cmd eq 'encrypt';
            @result.push(@matrix[$bm][($bn + 1) % 5]) if $cmd eq 'encrypt';
            @result.push(@matrix[$am][($an - 1) % 5]) if $cmd eq 'decrypt';
            @result.push(@matrix[$bm][($bn - 1) % 5]) if $cmd eq 'decrypt';
        } elsif $an == $bn {        # same column 
            @result.push(@matrix[($am + 1) % 5][$an]) if $cmd eq 'encrypt';
            @result.push(@matrix[($bm + 1) % 5][$bn]) if $cmd eq 'encrypt';
            @result.push(@matrix[($am - 1) % 5][$an]) if $cmd eq 'decrypt';
            @result.push(@matrix[($bm - 1) % 5][$bn]) if $cmd eq 'decrypt';
        } else {                    # different row and column
            @result.push(@matrix[$am][$bn]);
            @result.push(@matrix[$bm][$an]);
        }
    }
    my $result = @result.join('');
    say "'$result'";
}
