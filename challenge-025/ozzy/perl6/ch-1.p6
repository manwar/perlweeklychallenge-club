#!/usr/bin/env perl6

# PROBLEM: Find longest chain of Pokemon names wherein each next name starts with the last letter
# of the previous name.
#
# SOLUTION: Test all possible solutions and report every new record. 'Length' is defined as the number
# of chained names, and, subsidiarily, the overall number of characters. It turns out that there are 416
# longest chains (starting with 'machamp') that contain 23 names, with an overall number of characters
# of 174.

my @names = < audino bagon baltoy banette bidoof braviary bronzor carracosta charmeleon cresselia croagunk
              darmanitan deino emboar emolga exeggcute gabite girafarig gulpin haxorus heatmor heatran
              ivysaur jellicent jumpluff kangaskhan kricketune landorus ledyba loudred lumineon lunatone
              machamp magnezone mamoswine nosepass petilil pidgeotto pikachu pinsir poliwrath poochyena
              porygon2 porygonz registeel relicanth remoraid rufflet sableye scolipede scrafty seaking
              sealeo silcoon simisear snivy snorlax spoink starly tirtouga trapinch treecko tyrogue
              vigoroth vulpix wailord wartortle whismur wingull yamask >.sort;

my $max_seq_count = 0;
my $max_length    = 0;


sub search_next (@name, @names_left) {

    for @names_left.kv -> $idx_cand, $name_cand {

         next unless $name_cand.defined;

         my $f = $name_cand.comb[0];
         my $l = @name[*-1].comb[*-1];

         last if $f gt $l;
         next if $f lt $l;

         my @name_new = |@name, $name_cand;

         # New record length ?
         if @name_new.elems >= $max_seq_count {
             if @name_new.elems > $max_seq_count {
                 $max_seq_count = @name_new.elems;
                 $max_length = join('', @name_new).chars;
                 say $max_seq_count, ',', $max_length, ' -> ', @name_new;
             } else {
                 my $len = join('', @name_new).chars;
                 if $len >= $max_length {
                     $max_length = $len;
                     say $max_seq_count, ',', $max_length, ' -> ', @name_new;
                 }
             }
         }
         splice (my @names_left_new = @names_left), $idx_cand, 1, Nil;
         search_next @name_new, @names_left_new;
    }
}

for @names.kv -> $idx, $name {
    splice (my @names_left = @names), $idx, 1, Nil;
    search_next (my @name = $name), @names_left;
}