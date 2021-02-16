#!/usr/bin/perl
# The Weekly Challenge #099
# Task 2 Unique Subsequence

# idea: match letter by letter

use strict;
use warnings;

sub patt_to_word {
    my $patt = $_[0];
    my $word = $_[1];
    my $form;
    my @p = split ",", $patt;
    my @w = split "", $word;
    
    $form = $p[0] == 0 
                ? "[" . $w[$p[0]] 
                : (join "" , @w[0..$p[0]-1]) ."[".$w[$p[0]]  ;
    my $ptr = $p[0]+1; 
    
    for my $k (1..$#p-1) {
        if ($p[$k] == 0) {
            $form .= $w[$ptr+$p[$k]];
        } else {
            $form .= "]"
                . (join "", @w[ $ptr .. $ptr+$p[$k]-1 ])
                . "["
                 . $w[$ptr+$p[$k]]
        }
        $ptr = $ptr+$p[$k]+1;
    }
    
    if ($p[-1] == 0) {
        $form .= $w[$ptr+$p[-1]]."]";
    } else {
        $form .= "]" 
                . (join "", @w[ $ptr .. $ptr+$p[-1]-1 ])
                . "["
                . $w[$ptr+$p[-1]]
                ."]";
    }
    
    $ptr = $ptr+$p[-1]+1;
    
    if ($ptr < $#w) {
        $form .= (join "", @w[$ptr..$#w]);
    }
    
    return $form;
}

sub check {
    my $s_rightsub = $_[0];
    my $t_pattern = $_[1];
    my @app = @{$_[2]};

    if ((length $t_pattern) == 1) {     
        my @last_char_pos;
        my $i = index($s_rightsub, $t_pattern);
        while ($i > -1) {
            push @last_char_pos, $i;
            $i = index($s_rightsub, $t_pattern, $i+1);
        }
        my @new_app;
        if (scalar @last_char_pos == 0) {
            @app = map {$_ . "#"} @app;
            return \@app;
        } else {
            for my $k (@last_char_pos) {
                push @new_app, map {$_ . $k } @app;
            }
            return \@new_app;
        }
        return \@app;
    }
   
    my @ices; 
    my $i = index($s_rightsub,substr($t_pattern,0,1));
    while ($i != -1) {
       push @ices, $i;
       $i = index($s_rightsub,substr($t_pattern,0,1), $i+1);
    }
    if (!@ices) {
        my @temp_arr = map {$_ . "#"} @app;
        return \@temp_arr;
    }

    my @new_app;
    for $i (@ices) {
        my @poss = @{check( substr($s_rightsub, $i+1)
                     , substr($t_pattern,1) , [""] )};
        for my $s (@app) { 
            for my $t (@poss) {
                if (substr($t, -1, 1) ne "#") {
                    push @new_app, $s.$i.",".$t;
                }
            }
        }
    }
    return \@new_app;
}

my @ans =  @{check($ARGV[0],$ARGV[1], [""])} ;

if (!@ans) {print "Nothing matches!\n";}

for my $k (0..$#ans) {
    print $k+1,": ", patt_to_word($ans[$k]  , $ARGV[0]), "\n";
}
