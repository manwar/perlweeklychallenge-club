#!/usr/bin/perl
use v5.38;

sub bitwiseOR($listref) {
    my @list = @{$listref};

   my $result = shift @list;
   for my $elem (@list) {
      $result |= $elem;
   }

   return $result;
}

sub combinations($listref, $length) {
    my @list = @{$listref};

    if ($length <= 1) {
        return map [$_], @list;
    }

    my @combos;

    for (my $i = 0; $i + $length <= scalar @list; $i++) {
        my $val  = $list[$i];
        my @rest = @list[$i + 1 .. $#list];
        for my $c (combinations(\@rest, $length - 1)) {
            push @combos, [$val, @{$c}] ;
        }
    }

    return @combos;
}

my @ints = @ARGV;

for my $i (2 .. scalar @ints) {
   for my $combo (combinations(\@ints, $i)) {
      if ((split //, sprintf("%b", bitwiseOR($combo)))[-1] == '0') {
         say 'true';
         exit(0);
      }
   }
}
say 'false';