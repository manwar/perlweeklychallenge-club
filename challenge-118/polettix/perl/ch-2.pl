#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use List::Util qw< sum >;

my $input = shift // do {
   my $default = <<'END';
      a b c d e f g h
    8 N * * * * * * * 8
    7 * * * * * * * * 7
    6 * * * * x * * * 6
    5 * * * * * * * * 5
    4 * * x * * * * * 4
    3 * x * * * * * * 3
    2 x x * * * * * * 2
    1 * x * * * * * * 1
      a b c d e f g h
END
   \$default;
};
print_solution(adventure_of_knight(parse_input($input)));

sub adventure_of_knight ($input) {

   # First, analyze the setup to find the minimum distance/path from
   # every location on the board to every other location, accounting for
   # the knight way of moving
   my $max_X = $input->{row_names}->$#*;
   my $max_Y = $input->{col_names}->$#*;
   my $analysis = floyd_warshall(
      distance => sub { 1 },
      identifier => sub ($node) { join ',', $node->@* },
      start => $input->{knight},
      successors => sub ($node) {
         my ($x, $y) = $node->@*;
         my @succs;
         for my $long (-2, +2) {
            for my $short (-1, +1) {
               for my $p ([$long, $short], [$short, $long]) {
                  my ($X, $Y) = ($x + $p->[0], $y + $p->[1]);
                  push @succs, [$X, $Y]
                     if ($X >= 0) && ($X <= $max_X)
                     && ($Y >= 0) && ($Y <= $max_Y);
               }
            }
         }
         return @succs;
      },
   );

   # Second, evaluate the total distance over all possible sequencing of
   # treasures, keeping the path with the shorter distance. This is not
   # optimal as the number of treasures grows, but for a fixed number of
   # treasures at 6 it means that only 720 permutations have to be
   # considered, which is fair.
   my $pit = permutations_iterator(items => $input->{treasures});
   my ($min_distance, @min_path);
   while (my @path = $pit->()) {
      unshift @path, $input->{knight};
      my $distance = sum map {
         $analysis->{distance}->(@path[$_ - 1, $_]);
      } 1 .. $#path;
      ($min_distance, @min_path) = ($distance, @path)
         if ! defined($min_distance) || $distance < $min_distance;
   }

   # Last, adapt our finding to provide an array of path sections that
   # have to be walked in sequence. This is the main part of our output.
   my @sections = map {
      my @section = $analysis->{path}->(@min_path[$_ - 1, $_]);
      shift @section;
      \@section;
   } 1 .. $#min_path;
   return {
      $input->%*,
      sections => \@sections,
   };
}

sub print_solution ($solution) {
   my $position_for = sub ($x, $y) {
      $solution->{col_names}[$x] . $solution->{row_names}[$y];
   };
   my @stops = (
      $position_for->($solution->{knight}->@*) . '.N',
      map {
         my @section = map {$position_for->($_->@*)} $_->@*;
         $section[-1] = $section[-1] . '.x';
         @section;
      } $solution->{sections}->@*,
   );
   say join ' ', @stops;
   say scalar(@stops) - 1, ' moves';
}

sub parse_input ($fof) {
   my $fh = ref($fof) eq 'GLOB' ? $fof
      : (! ref($fof) && ($fof eq '-')) ? \*STDIN
      : do { open my $x, '<', $fof or die 'file...'; $x };
   my ($knight, @treasures, @row_names, @col_names);
   while (<$fh>) {
      s{\A\s+|\s+\z}{}gmxs;
      my @row = split m{\s+}mxs;

      if (m{\A \s* \d}mxs) {
         my $i = @row_names;
         push @row_names, shift @row;
         pop @row;

         for my $j (0 .. $#row) {
            my $char = $row[$j];
            if ($char eq 'N') {
               die "too many knights\n" if defined $knight;
               $knight = [$j, $i];
            }
            elsif ($char eq 'x') {
               push @treasures, [$j, $i];
            }
            elsif ($char ne '*') {
               die "invalid character '$char'\n";
            }
         }
      }
      elsif (! @col_names) {
         @col_names = @row;
      }
   }
   return {
      knight => $knight,
      treasures => \@treasures,
      row_names => \@row_names,
      col_names => \@col_names,
   };
}

sub floyd_warshall {
   my %args = (@_ && ref($_[0])) ? %{$_[0]} : @_;
   my @reqs = qw< distance successors >;
   exists($args{$_}) || die "missing parameter '$_'" for @reqs;
   my ($dist, $scs) = @args{@reqs};
   my $id_of = $args{identifier} || sub { return "$_[0]" };
   my @q = exists($args{starts}) ? @{$args{starts}}
      : exists($args{start}) ? ($args{start})
      : die "missing parameter 'starts' or 'start'";
   my (%d, %p, %nf); # distances, predecessors
   while (@q) { # initialization
      next if exists $nf{my $vi = $id_of->(my $v = shift @q)};
      for my $w ($scs->($nf{$vi} = $v)) {
         next if $vi eq (my $wi = $id_of->($w)); # avoid self-edges
         ($d{$vi}{$wi}, $p{$vi}{$wi}) = ($dist->($v, $w), $vi);
         push @q, $w unless exists $nf{$wi};
      }
      $d{$vi}{$vi} = 0;
   }
   my @vs = keys %nf;
   for my $vi (@vs) {
      for my $vv (@vs) {
         next unless exists $p{$vv}{$vi};
         for my $vw (@vs) {
            next if (!exists $d{$vi}{$vw}) || (exists($d{$vv}{$vw})
               && ($d{$vv}{$vw} <= $d{$vv}{$vi} + $d{$vi}{$vw}));
            $d{$vv}{$vw} = $d{$vv}{$vi} + $d{$vi}{$vw};
            $p{$vv}{$vw} = $p{$vi}{$vw};
         }
         return if $d{$vv}{$vv} < 0; # negative cycle, bail out
      }
   }
   return {
      has_path => sub {
         my ($vi, $wi) = map { $id_of->($_) } @_[0, 1];
         return exists($d{$vi}) && exists($d{$vi}{$wi});
      },
      distance => sub {
         my ($vi, $wi) = map { $id_of->($_) } @_[0, 1];
         return unless exists($d{$vi}) && exists($d{$vi}{$wi});
         return $d{$vi}{$wi};
      },
      path => sub {
         my ($fi, $ti) = map { $id_of->($_) } @_[0, 1];
         return unless exists($d{$fi}) && exists($d{$fi}{$ti});
         my @path;
         while ($ti ne $fi) {
            unshift @path, $nf{$ti};
            $ti = $p{$fi}{$ti};
         }
         unshift @path, $nf{$ti};
         return wantarray ? @path : \@path;
      },
   };
}

sub permutations_iterator {
   my %args = (@_ && ref($_[0])) ? %{$_[0]} : @_;
   my $items = $args{items} || die "invalid or missing parameter 'items'";
   my $filter = $args{filter} || sub { wantarray ? @_ : [@_] };
   my @indexes = 0 .. $#$items;
   my @stack = (0) x @indexes;
   my $sp = undef;
   return sub {
      if (! defined $sp) { $sp = 0 }
      else {
         while ($sp < @indexes) {
            if ($stack[$sp] < $sp) {
               my $other = $sp % 2 ? $stack[$sp] : 0;
               @indexes[$sp, $other] = @indexes[$other, $sp];
               $stack[$sp]++;
               $sp = 0;
               last;
            }
            else {
               $stack[$sp++] = 0;
            }
         }
      }
      return $filter->(@{$items}[@indexes]) if $sp < @indexes;
      return;
   }
}
