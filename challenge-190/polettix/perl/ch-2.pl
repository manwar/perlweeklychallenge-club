#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

# finds all ways of getting items close or separated. Each run of the
# iterator provides an array reference with a grouping.
my $groups_it = all_consecutive_groupings_iterator(shift // '1115');

# filters and transforms groupings into a target string. Each run of the
# iterator provides back a valid target decoded string.
my $dl_it = decoded_list_iterator($groups_it);

# expands an iterator in an array reference with all items
my $decoded_list = iterator_to_arrayref($dl_it);

# print it out
say join ', ', $decoded_list->@*;

sub iterator_to_arrayref ($it) {
   my @retval;
   while (my @stuff = $it->()) { push @retval, @stuff }
   return \@retval;
}

sub decoded_list_iterator ($groups_it) {
   state $letter_at = [undef, 'A' .. 'Z']; # starting at 1
   return sub {
      ARRANGEMENT:
      while (my $arrangement = $groups_it->()) {
         my @candidate = map {
            next ARRANGEMENT if m{\A 0 }mxs; # nothing starting with 0
            next ARRANGEMENT if $_ > $letter_at->$#*;
            $letter_at->[$_];
         } $arrangement->@*;
         return join '', @candidate;
      }
      return;
   }
}

sub all_consecutive_groupings_iterator ($string) {
   my @items = split m{}mxs, $string;
   my $n = 2 ** $#items;
   return sub {
      return if --$n < 0;
      my $code = sprintf '%b', $n; # decide which gets tied and which not

      # turn into spaces or empty strings (ties)
      my @code = map { $_ ? ' ' : '' } split m{}mxs, $code;
      unshift @code, '' while @code < $#items;

      # well... this can be enhanced a bit!!!
      return [ split m{\s+}mxs, join '', zip_loose(\@items, \@code)->@* ];
   };
}

# merge two lists together, until *both* have been used completely
sub zip_loose ($As, $Bs) {
   my ($Ai, $Bi) = (0, 0);
   my @retval;
   while ('necessary') {
      my $Aok = ($Ai <= $As->$#*) ? 1 : 0;
      my $Bok = ($Bi <= $Bs->$#*) ? 1 : 0;
      last unless $Aok || $Bok;
      my @chunk = (
         ($Aok ? $As->[$Ai++] : ()),
         ($Bok ? $Bs->[$Bi++] : ()),
      );
      push @retval, @chunk;
   }
   return \@retval;
}
