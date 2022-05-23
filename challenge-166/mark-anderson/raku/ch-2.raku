#!/usr/bin/env raku

use Test;

=begin dir_contents

dir_a              dir_b               dir_c               dir_d
-------------------------------------------------------------------------
Arial.ttf	       Arial.ttf	       Arial.ttf	       Arial.ttf
Comic_Sans.ttf	   Comic_Sans.ttf	   Courier_New.ttf	   Georgia.ttf
Georgia.ttf	       Courier_New.ttf	   Helvetica.ttf	   Helvetica.ttf
Helvetica.ttf	   Helvetica.ttf	   Impact.otf	       Impact.otf
Impact.otf	       Impact.otf	       Monaco.ttf	       Monaco.ttf
Old_Fonts/	       Tahoma.ttf	       Verdana.ttf	       Old_Fonts/
Verdana.ttf	       Verdana.ttf		                       Tahoma.ttf
			                                               Verdana.ttf
=end dir_contents

is k-dir-diff(<dir_a dir_b>), q:to/END/;
dir_a       | dir_b          
----------- | ---------------
            | Courier_New.ttf
Georgia.ttf |                
Old_Fonts/  |                
            | Tahoma.ttf     
END

is k-dir-diff(<dir_a dir_b dir_c>), q:to/END/;
dir_a          | dir_b           | dir_c          
-------------- | --------------- | ---------------
Comic_Sans.ttf | Comic_Sans.ttf  |                
               | Courier_New.ttf | Courier_New.ttf
Georgia.ttf    |                 |                
               |                 | Monaco.ttf     
Old_Fonts/     |                 |                
               | Tahoma.ttf      |                
END

is k-dir-diff(<dir_a dir_b dir_c dir_d>), q:to/END/;
dir_a          | dir_b           | dir_c           | dir_d      
-------------- | --------------- | --------------- | -----------
Comic_Sans.ttf | Comic_Sans.ttf  |                 |            
               | Courier_New.ttf | Courier_New.ttf |            
Georgia.ttf    |                 |                 | Georgia.ttf
               |                 | Monaco.ttf      | Monaco.ttf 
Old_Fonts/     |                 |                 | Old_Fonts/ 
               | Tahoma.ttf      |                 | Tahoma.ttf 
END

sub k-dir-diff(*@dirs)
{
    my %contents;

    for @dirs -> $dir
    {
        %contents{$dir} = qq:x{ls -F $dir}.split("\n", :skip-empty).List
    }

    my $bag = Bag.new: %contents.values.map: |*;

    my @lines = gather for $bag.keys.sort -> $file 
    {
        next if $bag{$file} == @dirs;

        my @line = gather for @dirs -> $dir
        {
            take %contents{$dir} (cont) $file ?? $file !! ''
        }
        
        take @line;
    }

    my $fmt = .join: ' | ' with gather for [Z] @lines
    {
        take '%-' ~ .classify({.chars}).keys.max ~ 's'
    }

    sprintf("$fmt\n", @dirs) ~
    sprintf($fmt.subst('-', '-.', :g) ~ "\n", '-' x 100 xx @dirs) ~
    @lines.map({sprintf("$fmt\n", .flat)}).join
}
