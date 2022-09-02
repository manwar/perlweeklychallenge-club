#!/usr/bin/env perl
use v5.24;
use warnings;
use experimental 'signatures';
no warnings 'experimental::signatures';
use I18N::Langinfo qw(langinfo CODESET);
use Encode qw(decode);

{
   package DoubleLinkedList;
   sub new ($p) { return bless { head => undef, tail => undef }, $p }
   sub push ($self, $value) {
      my $e = { value => $value, pred => $self->{tail}, succ => undef };
      $self->{tail}{succ} = $e if defined $self->{tail};
      $self->{tail} = $e;
      $self->{head} //= $e;
      return $self;
   }
   sub remove ($self, $e) {
      if (defined $e->{pred}) { $e->{pred}{succ} = $e->{succ} }
      else                    { $self->{head} = $e->{succ}    }
      if (defined $e->{succ}) { $e->{succ}{pred} = $e->{pred} }
      else                    { $self->{tail} = $e->{pred}    }
      return $self;
   }
}

my $codeset = langinfo(CODESET);
my $string = decode($codeset, shift(@ARGV) // 'Perl Weekly Challenge');

my $order = DoubleLinkedList->new;
my %dll_element_for;
my $i = 0;
for my $character (split m{}mxs, $string) {
   if (exists $dll_element_for{$character}) {
      if (defined $dll_element_for{$character}) {
         $order->remove($dll_element_for{$character});
         $dll_element_for{$character} = undef;
      }
   }
   else {
      $dll_element_for{$character} = $order->push($i)->{tail};
   }
   ++$i;
}

die "no result, sorry!\n" unless defined $order->{head};
say $order->{head}{value};
