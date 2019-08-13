#! /usr/bin/perl

use strict;
use warnings;
use URI::Escape;

foreach my $url (@ARGV) {
  my $u=urlparse($url);
  foreach my $mode (keys %{$u}) {
    if (exists $u->{$mode}) {
      $u->{$mode}=uri_unescape($u->{$mode});
    }
  }
  foreach my $mode (qw(scheme host)) {
    if (exists $u->{$mode}) {
      $u->{$mode}=lc($u->{$mode});
    }
  }
  if (exists $u->{port} && exists $u->{scheme}) {
    if (my $dp={http => 80,
                https => 443,
                ftp => 21,
                smtp => 25,
                telnet => 22,
                ldap => 389,
                ldaps => 686,
              }->{$u->{scheme}}) {
      if ($dp==$u->{port}) {
        delete $u->{port};
      }
    }
  }
  print urlassemble($u),"\n";
}

sub urlparse {
  my ($url)=@_;
  my %match;
  if ($url =~ m!//!) {
    $url =~ m!^(?<scheme>.*?)://(?:(?:(?<userinfo>.*)@)?(?<host>[-._a-z0-9]+)(?::(?<port>[0-9]+))?)?(?<pqf>.*)!i;
    map {$match{$_}=$+{$_}} keys %+;
  } else { # if no userinfo-host-port component, split on the last colon
    $url =~ m!^(?<scheme>.*):(?<pqf>[^:]*)!;
    map {$match{$_}=$+{$_}} keys %+;
  }
  $match{pqf} =~ m!(?<path>[^?#]*)(?:\?(?<query>[^#]*))?(?:\#(?<fragment>.*))?$!;
  map {$match{$_}=$+{$_}} keys %+;
  delete $match{pqf};
  return \%match;
}

sub urlassemble {
  my $u=shift;
  my $out=$u->{scheme}.':';
  if (exists $u->{host}) {
    $out.='//';
    if (exists $u->{userinfo}) {
      $out.=$u->{userinfo}.'@';
    }
    $out.=$u->{host};
    if (exists $u->{port}) {
      $out.=':'.$u->{port};
    }
  }
  $out.=$u->{path};
  if (exists $u->{query}) {
    $out.='?'.$u->{query};
  }
  if (exists $u->{fragment}) {
    $out.='#'.$u->{fragment};
  }
  return $out;
}
