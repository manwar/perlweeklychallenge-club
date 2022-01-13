#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';

say parse(shift);

# main entry point, useful for extracting the return value
sub parse ($exp) { return pf_PARSE(expression())->($exp)->[0] }

# <term> [+/- <term> [+/- <term> [...]]] | <group>
sub expression { pf_alternatives(canned_ops(term(), '-', '+'), group()) }

# <factor> [* <factor> [* <factor> [...]]]
sub term { canned_ops(factor(), '*') }

# <value> | <group>
sub factor { pf_alternatives(value(), group()) }

# '(' <expression> ')'
sub group {
   return sub {
      state $matcher = pf_sequence('(', expression(), ')');
      my $match = $matcher->(@_) or return;
      return $match->[1];
   }
}

# some integer without sign
sub value { pf_regexp(qr{\s*(0|[1-9]\d*)\s*}) }

# implementation of operand [op operand [op operand [...]]]
sub canned_ops ($operand, @operators) {
   my $ops = join '|', map { quotemeta } @operators ;
   my $op_opd = pf_sequence(pf_regexp(qr{\s*($ops)\s*}), $operand);
   my $matcher = pf_sequence($operand, pf_repeated($op_opd));
   return sub {
      my $match = $matcher->(@_) or return;
      my $retval = $match->[0][0];
      for my $opv ($match->[1]->@*) {
         my ($op, $val) = map { $_->[0] }$opv->@*;
         if    ($op eq '*') { $retval *= $val }
         elsif ($op eq '+') { $retval += $val }
         elsif ($op eq '-') { $retval -= $val }
      }
      return [ $retval ];
   }
}


# parsing facilities
sub pf_alternatives {
   my (@A, $r) = @_;
   return sub { (defined($r = $_->($_[0])) && return $r) for @A; return };
}

sub pf_exact {
   my ($wlen, $what, @retval) = (length($_[0]), @_);
   unshift @retval, $what unless scalar @retval;
   return sub {
      my ($rtext, $pos) = ($_[0], pos(${$_[0]}) || 0);
      return if length($$rtext) - $pos < $wlen;
      return if substr($$rtext, $pos, $wlen) ne $what;
      pos($$rtext) = $pos + $wlen;
      return [@retval];
   };
}

sub pf_list {
   my ($w, $s, $sep_as_last) = @_; # (what, separator, sep_as_last)
   $s = pf_exact($s) if defined($s) && !ref($s);
   return sub {
      defined(my $base = $w->($_[0])) or return;
      my $rp = sub { return ($s && !($s->($_[0])) ? () : $w->($_[0])) };
      my $rest = pf_repeated($rp)->($_[0]);
      $s->($_[0]) if $s && $sep_as_last; # attempt last separator?
      unshift $rest->@*, $base;
      return $rest;
   };
}

sub pf_match_and_filter {
   my ($matcher, $filter) = @_;
   return sub {
      my $match = $matcher->($_[0]) or return;
      return $filter->($match);
   };
}

sub pf_PARSE {
   my ($expression) = @_;
   return sub {
      my $rtext = ref $_[0] ? $_[0] : \$_[0]; # avoid copying
      my $ast = $expression->($rtext) or die "nothing parsed\n";
      my $pos = pos($$rtext) || 0;
      my $delta = length($$rtext) - $pos;
      return $ast if $delta == 0;
      my $offending = substr $$rtext, $pos, 72;
      substr $offending, -3, 3, '...' if $delta > 72;
      die "unknown sequence starting at $pos <$offending>\n";
   };
}

sub pf_regexp {
   my ($rx, @forced_retval) = @_;
   return sub {
      scalar(${$_[0]} =~ m{\G()$rx}cgmxs) or return;
      return scalar(@forced_retval) ? [@forced_retval] : [$2];
   };
}

sub pf_repeated { # *(0,-1) ?(0,1) +(1,-1) {n,m}(n,m)
   my ($w, $m, $M) = ($_[0], $_[1] || 0, (defined($_[2]) ? $_[2] : -1));
   return sub {
      my ($rtext, $pos, $lm, $lM, @retval) = ($_[0], pos ${$_[0]}, $m, $M);
      while ($lM != 0) { # lm = local minimum, lM = local maximum
         defined(my $piece = $w->($rtext)) or last;
         $lM--;
         push @retval, $piece;
         if ($lm > 0) { --$lm } # no success yet
         else         { $pos = pos $$rtext } # ok, advance
      }
      pos($$rtext) = $pos if $lM != 0;  # maybe "undo" last attempt
      return if $lm > 0;    # failed to match at least $min
      return \@retval;
   };
}

sub pf_sequence {
   my @items = map { ref $_ ? $_ : pf_exact($_) } @_;
   return sub {
      my ($rtext, $pos, @rval) = ($_[0], pos ${$_[0]});
      for my $item (@items) {
         if (defined(my $piece = $item->($rtext))) { push @rval, $piece }
         else { pos($$rtext) = $pos; return } # failure, revert back
      }
      return \@rval;
   };
}

{ my $r; sub pf_ws  { $r ||= pf_regexp(qr{(\s+)}) } }
{ my $r; sub pf_wso { $r ||= pf_regexp(qr{(\s*)}) } }
