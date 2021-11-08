#!/usr/bin/env raku
use v6;
sub MAIN ($target = 3) {
   {
      my $n3 = node(3, node(4, (5, 6).map({node($_)}) ));
      my $root = node(1, node(2), $n3);
      print-tree($root);
      put depth($root, $target);
   }
   put '';
   {
      my $n2 = node(2, node(4, node(6, (8, 9).map({node($_)}) )));
      my $n3 = node(3, node(5, node(7)));
      my $root = node(1, $n2, $n3);
      print-tree($root);
      put depth($root, $target);
   }
}

sub node ($l, *@c) { my $h = (label => $l, children => @c).hash }

sub print-tree ($root) {
   my %is-last;
   my @prefix;
   dfv(
      $root,
      discover-action => -> $n, $parent {
         my $label = 'o-- ' ~ $n<label>;
         if (@prefix) {
            put ' ', @prefix.join('');
            put ' ', @prefix[0..*-2].join(''), ' ', $label;
         }
         else {
            put $label;
         }
         @prefix[*-1] = '  ' if %is-last{$n<label>};
         @prefix.push: ' |';
         %is-last{$n<children>[*-1]<label>} = 1 if $n<children>.elems;
      },
      leave-action => -> $n, $parent { @prefix.pop },
   );
}

sub depth ($root, $label) {
   my $depth = 0;
   dfv(
      $root,
      discover-action => -> $n, $parent {
         return $depth if $n<label> eq $label;
         ++$depth;
      },
      leave-action => -> $n, $parent { --$depth },
   );
   return NaN;
}

sub dfv ($root, *%named) {
   return depth-first-visit(
      successors => -> $n {
         $n<children>:exists ?? $n<children>.Slip !! [].Slip },
      start      => [$root],
      identifier => -> $n { $n<label> },
      |%named,
   );
}

sub depth-first-visit (
      :&discover-action,       # first time a node is found
      :action(:&visit-action), # when node is visited
      :&skip-action,           # node skipped due previous visit
      :&leave-action,          # node visiting ends
      :identifier(:&id) = -> $item {~$item},
      :&successors!,
      :@start!,
) {
   my %a; # adjacent nodes
   my @s = @start.map: { &discover-action($_, Nil) if &discover-action;
                         %a{&id($_)} = [&successors($_)]; [$_, Nil] };
   while @s {
      my ($v, $pred) = @s[*-1]; # "top" of the stack
      &visit-action($v, $pred) if &visit-action;
      my $vid = &id($v);
      if %a{$vid}.elems {
         my $w = %a{$vid}.shift;
         my $wid = &id($w);
         if (%a{$wid}:exists) {
            &skip-action($w, $v) if &skip-action;
         }
         else {
            &discover-action($w, $v) if &discover-action;
            %a{$wid} = [&successors($w)];
            @s.push: [$w, $v];
         }
      }
      else {
         &leave-action($v, $pred) if &leave-action;
         @s.pop;
      }
   }
   return %a.keys;
}
