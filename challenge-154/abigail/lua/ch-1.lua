#!/opt/local/bin/lua

--
-- See https://theweeklychallenge.org/blog/perl-weekly-challenge-154
--

--
-- Run as: lua ch-1.lua < input-file
--

local p = {PERL = 1, PELR = 1, PREL = 1, PRLE = 1, PLER = 1, PLRE = 1,
           EPRL = 1, EPLR = 1, ERPL = 1, ERLP = 1, ELPR = 1, ELRP = 1,
           REPL = 1, RELP = 1, RPEL = 1, RPLE = 1, RLEP = 1, RLPE = 1,
           LERP = 1, LEPR = 1, LREP = 1, LRPE = 1, LPER = 1, LPRE = 1,}

for line in io . lines () do
    p [line] = nil
end

for key, _ in pairs (p) do
    print (key)
end
