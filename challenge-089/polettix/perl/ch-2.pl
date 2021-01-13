#!/usr/bin/env perl
use 5.024;
use warnings;
use experimental qw< postderef signatures >;
no warnings qw< experimental::postderef experimental::signatures >;
use Storable 'dclone';

my $M = magical_matrix(shift || 3);
say {*STDOUT} '[ ', (map { sprintf '%3d', $_ } $_->@*), ' ]' for $M->@*;

sub magical_matrix ($N) {
   my $N2 = $N * $N;
   my $solution = solve_by_constraints(
      start => {
         not_allocated => { map {$_ => 1} 1 .. $N2 },
         field => [ (0) x $N2 ],
         fine  => {},
      },
      is_done => sub ($state) { keys($state->{not_allocated}->%*) == 0 },
      constraints => [
         (map {_constraint($N, $_ * $N,  1)} 0 .. ($N - 1)), # rows
         (map {_constraint($N, $_,      $N)} 0 .. ($N - 1)), # cols
         _constraint($N, 0,      $N + 1),                    # main diag
         _constraint($N, $N - 1, $N - 1),                    # other diag
      ],
      search_factory => \&_search_factory,
   ) or die "cannot find a solution for N = $N\n";
   my $field = $solution->{field};
   return [map {[splice $field->@*, 0, $N]} 1 .. $N];
}

sub _search_factory ($state) {
   my %not_allocated = $state->{not_allocated}->%*;
   my @candidates = keys %not_allocated;
   my $current = undef;

   my @field = $state->{field}->@*;
   my $pos = undef;
   for my $i (0 .. $#field) {
      next if $field[$i];
      $pos = $i;
      last;
   }
   die 'no unassigned position (WTF?!?)' unless defined $pos;

   my %fine = $state->{fine}->%*;

   return sub ($state) {
      return 0 unless @candidates;

      $not_allocated{$current} = 1 if defined $current;
      $current = shift @candidates;
      delete $not_allocated{$current};

      $field[$pos] = $current;
      $state->{field}   = [@field];
      $state->{not_allocated} = { %not_allocated };
      $state->{fine} = { %fine };

      return 1;
   };
}

sub _constraint ($N, $start, $delta) {
   my $N2 = $N * $N;
   my $target_sum = ($N2 + 1) * $N / 2;
   return sub ($state) {
      return 0 if $state->{fine}{"$start-$delta"};
      my ($field, $not_allocated) = $state->@{qw< field not_allocated >};
      my $available = $target_sum;
      my @missing_indexes;
      my $j = 0;
      while ($j < $N) {
         my $i = $start + $delta * $j++;
         if (my $v = $field->[$i]) { $available -= $v }
         else                      { push @missing_indexes, $i }
      }
      die "wrong sum, too much" if $available < 0;
      my $n_missing = scalar @missing_indexes;

      if ($n_missing == 0) { # every value is fixed here, check the sum
         die 'wrong sum' if $available;
         $state->{fine}{"$start-$delta"} = 1;
         return 0; # check OK, no change
      }

      if ($n_missing == 1) { # fix the one that's left
         die "invalid residual value"
            unless exists $not_allocated->{$available};
         delete $not_allocated->{$available};
         $field->[$missing_indexes[0]] = $available;
         return 1; # yes, we did one change
      }

      return 0; # no change happened
   }
}

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
         } ## end while ($changed != 0)
         $done->($state) || (push(@stack, $factory->($state)) && undef);
      };
      $logger->(backtrack => $state, $@) if $logger;
      while (@stack) {
         last if $stack[-1]->($state);
         pop @stack;
      }
      return unless @stack;
   } ## end while ('necessary')
   return $state;
} ## end sub solve_by_constraints
