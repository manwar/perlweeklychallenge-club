#!/usr/bin/env raku
use v6;

class EertreE {
   has $.string;
   has @.suffixes;

   method new ($string) {
      my @suffixes =
         hash(            'length', -1, 'pred', 0),
         hash('start', 0, 'length', 0,  'pred', 0);

      for 0 ..^ $string.chars -> $i {
         my $c := $string.substr: $i, 1;

         # find longest suffix Q such that cQc exists
         my $Q = @suffixes[*-1];
         while ($Q<length> >= 0) {
            my $j = $i - $Q<length> - 1; # "mirror" of $i
            last if $j >= 0 && $c eq $string.substr($j, 1);
            $Q = @suffixes[$Q<pred>];
         }

         next if $Q<expansion-for>{$c}:exists;

         # adding a node as an expansion from $Q
         @suffixes.push: hash(
            'start',  $i - $Q<length> - 1,
            'length', $Q<length> + 2,
            'pred',   1, # this is just an educated guess default
         );
         $Q<expansion-for>{$c} = @suffixes.end;
         next if $Q<length> < 0; # solitary, no further search needed

         $Q = @suffixes[$Q<pred>]; # start from the previous one
         while ($Q<length> >= 0) {
            my $j = $i - $Q<length> - 1; # "mirror" of $i
            last if $j >= 0 && $c eq $string.substr($j, 1);
            $Q = @suffixes[$Q<pred>];
         }
         @suffixes[*-1]<pred> = $Q<expansion-for>{$c};
      }

      self.bless(:$string, :@suffixes);
   }

   method string-for ($i) {
      return '«-1»' if $i == 0;
      my ($start, $length) = @.suffixes[$i]<start length>;
      return q{'} ~ $.string.substr($start, $length) ~ q{'};
   }

   method dot () {
      my @lines;
      for ^@.suffixes -> $i {
         my $name = self.string-for($i);

         my $suffix = @.suffixes[$i];
         my $pred = self.string-for($suffix<pred>);
         @lines.push: qq{"$name" -> "$pred" [color=blue]};

         my $exps = $suffix<expansion-for> or next;
         for $exps.kv -> $c, $tid {
            my $target = self.string-for($tid);
            @lines.push: qq{"$name" -> "$target" [color=black label="$c"]};
         }
      }
      s{^^} = '   ' for @lines;
      return ('digraph {', @lines, '}').flat.join("\n");

   }
};

sub MAIN (Str $string = 'eertree') {
   my $eertree = EertreE.new($string);
   $eertree.dot.say;
}
