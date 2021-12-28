#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

my $string = shift // 'eertree';
my $eertree = EertreE->new($string);
say $eertree->dot;

package EertreE;
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

sub new ($package, $string) {
   my @suffixes = (
      {            length => -1, pred => 0 },
      {start => 0, length => 0,  pred => 0 },
   );

   for my $i (0 .. length($string) - 1) {
      my $c = substr $string, $i, 1;

      # find longest suffix Q such that cQc exists
      my $Q = $suffixes[-1];
      while ($Q->{length} >= 0) {
         my $j = $i - $Q->{length} - 1; # "mirror" of $i
         last if $j >= 0 && $c eq substr $string, $j, 1;
         $Q = $suffixes[$Q->{pred}];
      }

      next if exists $Q->{expansion_for}{$c};

      # adding a node as an expansion from $Q
      push @suffixes, {
         start  => $i - $Q->{length} - 1,
         length => $Q->{length} + 2,
         pred   => 1, # this is just an educated guess default
      };
      $Q->{expansion_for}{$c} = $#suffixes;
      next if $Q->{length} < 0; # solitary, no further search needed

      $Q = $suffixes[$Q->{pred}]; # start from the previous one
      while ($Q->{length} >= 0) {
         my $j = $i - $Q->{length} - 1; # "mirror" of $i
         last if $j >= 0 && $c eq substr $string, $j, 1;
         $Q = $suffixes[$Q->{pred}];
      }
      $suffixes[-1]{pred} = $Q->{expansion_for}{$c};
   }

   return bless {
      string => $string,
      suffixes => \@suffixes,
   }, $package;
}

sub string_for ($self, $i) {
   return '«-1»' if $i == 0;
   my ($start, $length) = $self->{suffixes}[$i]->@{qw< start length >};
   return q{'} . substr($self->{string}, $start, $length) . q{'};
}

sub dot ($self) {
   my $suffixes = $self->{suffixes};
   my @lines;
   for my $i (0 .. $suffixes->$#*) {
      my $name = $self->string_for($i);

      my $suffix = $suffixes->[$i];
      my $pred = $self->string_for($suffix->{pred});
      push @lines, qq{"$name" -> "$pred" [color=blue]};

      my $exp_for = $suffix->{expansion_for} or next;
      while (my ($c, $tid) = each $exp_for->%*) {
         my $target = $self->string_for($tid);
         push @lines, qq{"$name" -> "$target" [color=black label="$c"]};
      }
   }
   s{^}{   } for @lines;
   return join "\n", 'digraph {', @lines, '}';
}
