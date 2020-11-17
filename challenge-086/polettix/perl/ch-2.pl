#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use Storable qw< dclone >;
use autodie;

sub sudoku_puzzle ($puzzle) {
   $puzzle = dclone($puzzle); # don't mess with the original!
   my %missing; # records how many alternatives are for undecided positions
   for my $row (0 .. 8) {
      for my $col (0 .. 8) {
         next unless $puzzle->[$row][$col] eq '_';
         $puzzle->[$row][$col] = [ 1 .. 9 ];
         $missing{"$row-$col"} = 9;
      }
   }
   my $state = solve_by_constraints(
      is_done => sub ($state) { # we're done when there's no more missing
         return keys $state->{missing}->%* == 0;
      },
      constraints => [
         constraint_group_factory( # rows
            [map { [$_, 0] } 0 .. 8], # outer loop
            [map { [0, $_] } 0 .. 8], # inner loop
         ),
         constraint_group_factory( # columns
            [map { [0, $_] } 0 .. 8], # outer loop
            [map { [$_, 0] } 0 .. 8], # inner loop
         ),
         constraint_group_factory( # 3x3 blocks
            [map { ([$_, 0], [$_, 3], [$_, 6]) } (0, 3, 6)], # outer
            [map { ([$_, 0], [$_, 1], [$_, 2]) } (0, 1, 2)], # inner
         ),
      ],
      search_factory => \&search_factory,
      start => {
         field => $puzzle,
         missing => \%missing,
      },
   );
   return $state->{field};
}

# this sub generates sub references that can be used to iterate over
# different "alternatives" in undecided locations.
sub search_factory ($state) {
   my $field = $state->{field};
   my %missing = $state->{missing}->%*;
   my ($target, $tn);
   for my $candidate (keys %missing) {
      ($target, $tn) = ($candidate, $missing{$candidate})
         if (! defined $target) || ($tn > $missing{$candidate});
   }
   delete $missing{$target};
   my ($row, $col) = split m{-}mxs, $target;
   my @values = $field->[$row][$col]->@*;
   return sub ($state) {
      return unless @values;
      $state->{missing} = {%missing};
      my $f = $state->{field} = dclone($field);
      $f->[$row][$col] = shift @values;
      return 1;
   },
}

sub constraint_group_factory ($bases, $deltas) {
   return sub ($state) {
      my $field = $state->{field};
      my $changes = 0;
      for my $group (0 .. 8) {
         my ($row, $col) = $bases->[$group]->@*;
         my (%present, @vague);
         for my $delta ($deltas->@*) {
            my ($r, $c) = ($row + $delta->[0], $col + $delta->[1]);
            my $item = $field->[$r][$c];
            if (ref $item) { push @vague, [$r, $c] }
            elsif ($present{$item}) { die 'overlap!' }
            else { $present{$item} = 1 }
         }
         for my $pair (@vague) {
            my ($r, $c, @kept) = $pair->@*;
            for my $candidate ($field->[$r][$c]->@*) {
               if ($present{$candidate}) { $changes++ }
               else { push @kept, $candidate }
            }
            if (@kept == 0) { die 'no way forward here' }
            elsif (@kept == 1) {
               $field->[$r][$c] = $kept[0];
               $present{$kept[0]} = 1;
               delete $state->{missing}{"$r-$c"};
            }
            else {
               $field->[$r][$c] = \@kept;
               $state->{missing}{"$r-$c"} = scalar @kept;
            }
         }
      }
      return $changes;
   };
}

# https://github.com/polettix/cglib-perl/blob/master/ConstraintSolver.pm
# https://github.com/polettix/cglib-perl/blob/master/ConstraintSolver.pod
sub solve_by_constraints {
   my %args = (@_ && ref($_[0])) ? %{$_[0]} : @_;
   my @reqs = qw< constraints is_done search_factory start >;
   exists($args{$_}) || die "missing parameter '$_'" for @reqs;
   my ($constraints, $done, $factory, $state, @stack) = @args{@reqs};
   my $logger = $args{logger} // undef;
   while ('necessary') {
      last if eval {    # eval - constraints might complain loudly...
         $logger->(validating => $state) if $logger;
         my $changed = -1;
         while ($changed != 0) {
            $changed = 0;
            $changed += $_->($state) for @$constraints;
            $logger->(pruned => $state) if $logger;
         }
         $done->($state) || (push(@stack, $factory->($state)) && undef);
      };
      $logger->(backtrack => $state, $@) if $logger;
      while (@stack) {
         last if $stack[-1]->($state);
         pop @stack;
      }
      return unless @stack;
   }
   return $state;
}

sub debug_puzzle ($puzzle) {
   my $i = 1;
   my $is_solving = 0;
   CHECK_FINAL:
   for my $row ($puzzle->@*) {
      for my $item ($row->@*) {
         next unless ref $item;
         $is_solving = 1;
         last CHECK_FINAL;
      }
   }
   for my $row ($puzzle->@*) {
      my @row = $row->@*;
      my @line = map { join ' ', '[', map ({
            $is_solving ? sprintf('%19s', ref $_ ? "{@$_}" : $_) : $_
         } splice(@row, 0, 3)), ']' } 1 .. 3;
      say {*STDERR} join ' ', @line;
      print {*STDERR} "\n" if ($i % 3 == 0) && ($i < 9);
      ++$i;
   } ## end for my $row ($puzzle->@*)
   return;
}

sub print_puzzle ($puzzle) {
   say {*STDOUT} join ' ', '[', $_->@*, ']' for $puzzle->@*;
   return;
}

sub main ($filename = undef) {
   my $fh =
       !defined($filename) ? \*DATA
     : ($filename eq '-')  ? \*STDIN
     :                       do { open my $fh, '<', $filename; $fh };
   my @puzzle;
   while (<$fh>) {
      my @line = grep { m{[_1-9]} } split m{\s+}mxs;
      die "wrong number of elements in line $.\n" unless @line == 9;
      push @puzzle, \@line;
      last if $. == 9;
   } ## end while (<$fh>)
   die "not enough rows\n" unless @puzzle == 9;
   debug_puzzle(\@puzzle);
   print {*STDERR} "\n";
   my $solved_puzzle = sudoku_puzzle(\@puzzle);
   print_puzzle($solved_puzzle);
   print {*STDERR} "\n";
   debug_puzzle($solved_puzzle);
   return;
} ## end sub main ($filename = undef)

main(@ARGV);

__DATA__
[ _ 4 9 7 3 _ _ _ _ ]
[ _ _ 8 _ _ _ 6 7 _ ]
[ _ 7 6 _ 5 _ _ _ _ ]
[ _ _ 7 9 _ _ _ _ _ ]
[ _ 6 _ _ _ _ _ 5 _ ]
[ _ _ _ _ _ 1 7 _ _ ]
[ _ _ _ _ 1 _ 8 2 _ ]
[ _ 9 1 _ _ _ 4 _ _ ]
[ _ _ _ _ 2 7 5 1 _ ]
