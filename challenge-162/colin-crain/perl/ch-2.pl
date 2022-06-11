#!/Users/colincrain/perl5/perlbrew/perls/perl-5.32.0/bin/perl
#
#       all-is-fair-play-at-the-mill.pl
#
#       Wheatstone-Playfair
#         Submitted by: Roger Bell_West
#         Implement encryption and decryption using the Wheatstone-Playfair cipher.
# 
#         Examples:
#         (These combine I and J, and use X as padding.)
# 
#         encrypt("playfair example", "hide the gold in the tree stump") = "bmodzbxdnabekudmuixmmouvif"
# 
#         decrypt("perl and raku", "siderwrdulfipaarkcrw") = "thewexeklychallengex"
#
#       © 2022 colin crain
## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ## ##



use warnings;
use strict;
use utf8;
use feature ":5.26";
use feature qw(signatures);
no warnings 'experimental::signatures';
use constant { PAD => 'Q' };

my $phrase    = shift @ARGV // 'playfair example';
my $text      = shift @ARGV // 'hide the gold in the tree stump';
my $cypher    = encode( $phrase, $text );
my $plaintext = decode( $phrase, $cypher );

say<<~"END";

    input:      $text
    passphrase: $phrase
---------------------------------

    cyphertext: 
    
        $cypher
    
    decoded plaintext:  
    
        $plaintext
    
END




## subroutines

sub encode( $phrase, $text ) {
    return _quints( _code($phrase, $text, 1) );
}

sub decode( $phrase, $text ) {
    return _code( $phrase, $text, -1)
}




sub _code( $phrase, $text, $shift ) {
    my ($kh, $ka) = _key_table( $phrase );
    $text =~ s/\W//g;                       ## strip spaces and nonword chars
    $text =~ tr/a-z/A-Z/;                   ## uppercase
    my @text = split //, $text; 
    
    my @dgs;
    while (@text) {                         ## setup digram pairs
        my $digram = [shift @text];
        $digram->[1] = ($text[0] eq $digram->[0]) 
            ? PAD                          ## pad if duplicate
            : shift @text || PAD;          ## shift next char or backfill w/pad
        push @dgs, $digram;
    }
    
    my @out;
    for my $dg (@dgs) {
        ## same row, shift right and wrap
        if ($kh->{$dg->[0]}->[0] eq $kh->{$dg->[1]}->[0]) {         
            push @out, $ka->[$kh->{$dg->[0]}->[0]][($kh->{$dg->[0]}->[1]+$shift)%5], 
                       $ka->[$kh->{$dg->[1]}->[0]][($kh->{$dg->[1]}->[1]+$shift)%5] ;
        }
        ## same col, shift down and wrap
        elsif ($kh->{$dg->[0]}->[1] eq $kh->{$dg->[1]}->[1]) {      
            push @out, $ka->[($kh->{$dg->[0]}->[0]+$shift)%5][$kh->{$dg->[0]}->[1]], 
                       $ka->[($kh->{$dg->[1]}->[0]+$shift)%5][$kh->{$dg->[1]}->[1]] ;
       
        }
        ## rectangle, swap in same row with char at complement column position
        else {                                                      
            push @out, $ka->[$kh->{$dg->[0]}->[0]][$kh->{$dg->[1]}->[1]], 
                       $ka->[$kh->{$dg->[1]}->[0]][$kh->{$dg->[0]}->[1]] ;
        }
    }
    
    return join '', @out;
}

sub _key_table ($phrase) {
    $phrase =~ s/\W//g;                     ## strip spaces and nonword
    $phrase =~ tr/a-z/A-Z/;                 ## uppercase
    my @phrase = split //, $phrase;    
    
    my %alpha = map { $_ => 1 }             ## 25-letter alpha hash
                ("A".."I", "K".."Z");   
    my ($i, $j) = (0, 0);
    my $khash;
    my $karr;
    
    ## first assign unique phrase letters, then remaining alphabet
    for (@phrase, sort keys %alpha ) {                 
        next if not exists $alpha{$_};
        $khash->{$_} = [$i, $j] and delete $alpha{$_};
        $karr->[$i][$j] = $_;
        ++$j > 4 and ($i, $j) = (++$i, 0);
    }
    
    return $khash, $karr;
}


sub _quints( $text ) {
## arrange cypher as 5-char groupings with random backfill for last group
    my @alpha = ("A".."I", "K".."Z");  ## 25 chars
    my $fill  = 5 - length($text) % 5;
       $text .= $alpha[rand(25)] while $fill--;
       $text  =~ s/(.{5})/$1 /g;
       
    return $text;
}


