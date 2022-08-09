use v6.d;

unit sub MAIN();
(^∞).grep({!/0/}).map({$_~0~.flip}).grep(&is-prime).head(20).join(', ').say
# ; say now - INIT now ;
