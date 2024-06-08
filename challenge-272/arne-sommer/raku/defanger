#! /usr/bin/env raku

subset IPv4 where /^(\d+)\.(\d+)\.(\d+)\.(\d+)$/ && all($0,$1,$2,$3) < 256;

unit sub MAIN (IPv4 $ipv4);

say $ipv4.split('.').join('[.]');