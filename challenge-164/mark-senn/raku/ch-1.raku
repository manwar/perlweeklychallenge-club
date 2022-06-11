(2..^1000).grep({.is-prime && $_ eq flip $_}).say;
