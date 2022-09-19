#!/usr/bin/env raku
use v6;

put k-directory-diff(< dir_a dir_b dir_c >);

sub k-directory-diff (*@dirs) {
   my @lists = select-incompletes(@dirs.map({list-from($_)}));
   for @lists Z @dirs -> ($l, $d) { $l.unshift: $d }
   return render-columns(@lists);
}

sub list-from ($dir) {
   $dir.IO.dir.map({.basename ~ (.d ?? '/' !! '') }).Array
}

sub select-incompletes (@lists) {
   my (@retval, @sets);
   my $union = SetHash.new;
   my $intersection = SetHash.new(@lists[0].Slip);
   for @lists -> $list {
      my $set = set(@$list);
      $union ∪= $set;
      $intersection ∩= $set;
      @sets.push: $set;
      @retval.push: [];
   }
   for $union.keys.sort({$^a cmp $^b}) -> $item {
      next if $item ∈ $intersection;
      for @retval Z @sets -> ($r, $s) {
         $r.push($item ∈ $s ?? $item !! '');
      }
   }
   return @retval;
}

sub render-columns (@columns) {
   my @widths = @columns.map({$_».chars.max});
   my $format = @widths.map({"%-{$_}s"}).join(' | ');
   my $separator = $format.sprintf(@widths.map({'-' x $_}));
   my ($head, @retval) = (^@columns[0].elems).map(-> $i {
      $format.sprintf(@columns.map({$_[$i]}));
   });
   ($head, $separator, |@retval).join("\n");
}
