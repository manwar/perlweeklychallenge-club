#!/usr/bin/env lua

local t1 = {}
local util = require'util'

t1.DEFAULT_DNA = 'GTAAACCCCTTTTCATTTAGACAGATCGACTCCTTATCCATTCTCAGAGATGTGTTGCTGGTCGCCG'

function t1.process_dna(dna)
  freq = {}
  for c in dna:gmatch'.' do
    freq[c] = (freq[c] or 0) + 1
  end

  local replacement = {A='T', T='A', C='G', G='C'}
  local complement = dna:gsub('(%w)', function (c) return replacement[c] end)

  return freq, complement
end

function t1.run(args)
  local dna = args[1] or t1.DEFAULT_DNA
  local freq, complement = t1.process_dna(dna)

  io.write('Counts = { ')
  local seq = util.dict_to_seq(freq)
  for i, v in ipairs(seq) do
    io.write(v[1] .. ': ' .. v[2])
    if i ~= #seq then io.write(', ') end
  end
  print(' }\n')

  print('Complement: ' .. complement)
end

return t1
