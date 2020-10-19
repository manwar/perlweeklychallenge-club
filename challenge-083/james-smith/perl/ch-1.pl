#!/usr/local/bin/perl

use strict;
use warnings;
use Test::More;

is( other_chars( 'The Weekly Challenge' ), 6 );
is( other_chars( 'The purpose of our lives is to be happy' ), 23 );
is( other_chars( 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Maecenas fringilla tincidunt velit, euismod vulputate arcu tristique a. Cras malesuada bibendum erat, sed ullamcorper diam egestas at. Lorem ipsum dolor sit amet, consectetur adipiscing elit. Orci varius natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Phasellus venenatis dolor dolor, quis dictum mauris mattis finibus. Praesent feugiat neque vulputate erat consequat, quis dignissim risus vestibulum. Phasellus feugiat tellus vestibulum tellus eleifend sodales. Aenean non feugiat mauris. Praesent eu nisl a nunc rhoncus pharetra id non mi. Vestibulum ante ipsum primis in faucibus orci luctus et ultrices posuere cubilia curae; Duis tincidunt scelerisque erat, sagittis sagittis quam laoreet non. Cras convallis lacinia nisl, eget vehicula ante consequat eu. Etiam justo tellus, scelerisque vel consectetur id, feugiat sed tellus.

Cras et turpis augue. Nulla nec dolor odio. Fusce placerat nisi sit amet magna accumsan, sit amet facilisis turpis tincidunt. Integer velit erat, suscipit eu pretium nec, pretium eget tellus. Aliquam eleifend laoreet velit id feugiat. Donec sit amet ultrices turpis, nec mollis ante. Praesent et odio eu ligula luctus aliquam. Donec semper ligula sit amet ante auctor, non consequat est vulputate. Sed gravida, ipsum in condimentum maximus, sapien eros lacinia dolor, quis molestie neque magna nec dolor. Aliquam diam magna, euismod vitae justo in, sagittis mollis ipsum. Suspendisse a erat turpis. Vestibulum blandit orci ut imperdiet egestas.

Quisque lacinia euismod orci, ac vulputate dui pellentesque et. Suspendisse vitae diam odio. Curabitur lacinia pellentesque mi non ultricies. Nulla suscipit vitae ipsum nec hendrerit. Cras in commodo lorem, sit amet iaculis tellus. Integer maximus tellus varius, facilisis orci placerat, volutpat est. Donec non neque sodales, ullamcorper massa at, feugiat massa. Cras interdum est ac porta malesuada. Nunc sed mi ante. Nulla vitae pellentesque erat.

Nulla vitae leo accumsan, tincidunt ex nec, malesuada mi. Praesent sed finibus dui. Suspendisse aliquam mauris sed consectetur interdum. Proin bibendum tellus orci, a interdum ligula tincidunt rhoncus. Pellentesque lorem neque, venenatis et aliquet vel, lacinia et libero. Suspendisse nec urna ut dolor volutpat aliquet. Aenean faucibus porttitor risus vel ultricies.

Aliquam id blandit nulla. Phasellus pharetra diam sed malesuada congue. Ut sit amet congue eros. Suspendisse potenti. Sed aliquet erat massa, non tincidunt ligula mollis et. Sed ac elementum libero, id viverra justo. Nullam non ante posuere ligula porta congue sollicitudin a nisi. Donec fringilla nibh a bibendum ullamcorper. Sed sed bibendum diam. Vestibulum nec urna sem. Donec enim quam, viverra sit amet porttitor ac, tempus sed diam. Vivamus lacinia leo sit amet aliquet porttitor. Donec accumsan consequat scelerisque. Integer ultrices mi ut pretium interdum' ), 2508 );

done_testing;

sub other_chars {
  my @A = split m{\s+}, shift; ## split into words...
  pop @A;                      ## remove first
  shift @A;                    ## and last
  return length join q(), @A;  ## compute length of words - simpler to join...
}
