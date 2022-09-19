#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use File::Spec::Functions qw< splitpath catpath >;

k_directory_diff(qw< dir_a dir_b dir_c >);

sub k_directory_diff (@dirs) {
   my @lists = select_incompletes(map { [list_from($_)] } @dirs);
   unshift $lists[$_]->@*, $dirs[$_] for 0 .. $#dirs;
   say render_columns(@lists);
}

sub list_from ($dir) {
   opendir my $dh, $dir or die "opendir('$dir'): $!\n";
   my ($v, $dirs) = splitpath($dir, 'no-file');
   return map {
      my $path = catpath($v, $dirs, $_);
      -d $path ? "$_/" : $_;
   } readdir($dh);
}

sub select_incompletes (@lists) {
   my (@retval, %union, %intersection);
   @intersection{$lists[0]->@*} = ();
   for my $list (@lists) {
      @union{$list->@*} = ();
      %intersection = map { $_ => 1 }
         grep { exists $intersection{$_} } $list->@*;
      $list = { map { $_ => $_ } $list->@* };
      push @retval, [];
   }
   for my $item (sort { $a cmp $b } keys %union) {
      next if exists $intersection{$item};
      for my $i (0 .. $#lists) {
         push $retval[$i]->@*, $lists[$i]{$item} // '';
      }
   }
   return @retval;
}

sub render_columns (@columns) {
   my @widths = map {
      my $width = 0;
      for my $item ($_->@*) {
         my $w = length $item;
         $width = $w if $width < $w;
      }
      $width;
   } @columns;
   my $format = join ' | ', map {; "%-${_}s" } @widths;
   my $separator = sprintf $format, map { '-' x $_ } @widths;
   my ($head, @retval) = map {
      my $i = $_;
      sprintf $format, map { $_->[$i] } @columns
   } 0 .. $columns[0]->$#*;
   return join "\n", $head, $separator, @retval;
}
