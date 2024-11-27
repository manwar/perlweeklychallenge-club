#! /usr/bin/crystal

def counterify(a)
  cc = Hash(Int32, Int32).new(default_value: 0)
  a.each do |x|
    cc[x] += 1
  end
  return cc
end

deck = Array(Tuple(Int32, Int32)).new
0.upto(3) do |suit|
  1.upto(13) do |rank|
    deck.push({rank, suit})
  end
end

hands = Hash(Int32, Int32).new(default_value: 0)
deck.combinations(5).each do |hand|
  bin = 0
  ranks = hand.map{|x| x[0]}.sort
  ranksc = counterify(ranks)
  ranksk = ranksc.values.sort.reverse
  suits = hand.map{|x| x[1]}.sort
  suitsc = counterify(suits)
  suitsk = suitsc.values.sort.reverse
  # Can't generate 5 of a kind.
  # Royal flush
  if suitsc.size == 1 &&
     ranks == [1, 10, 11, 12, 13]
    bin = 2
  end
  # Straight flush
  if bin == 0 &&
     suitsc.size == 1 &&
     ranks.min + 4 == ranks.max
    bin = 2
  end
  # Four of a kind
  if bin == 0 && ranksk[0] == 4
    bin = 3
  end
  # Full house
  if bin == 0 && ranksk[0] == 3 && ranksk[1] == 2
    bin = 4
  end
  # Flush
  if bin == 0 && suitsk[0] == 5
    bin = 5
  end
  # Straight
  if bin == 0 &&
     # match full rank struct
     (
       (ranks[0] + 1 == ranks[1] &&
                   ranks[1] + 1 == ranks[2] &&
                              ranks[2] + 1 == ranks[3] &&
                                         ranks[3] + 1 == ranks[4]) ||
       ranks == [1, 10, 11, 12, 13]
     )
    bin = 6
  end
  # Three of a kind
  if bin == 0 && ranksk[0] == 3
    bin = 7
  end
  # Two pair
  if bin == 0 && ranksk[0] == 2 && ranksk[1] == 2
    bin = 8
  end
  # One pair
  if bin == 0 && ranksk[0] == 2
    bin = 9
  end
  # Anything else is High card
  if bin == 0
    bin = 10
  end
  hands[bin] += 1
end
tot = 0
hands.keys.sort.each do |k|
  print("#{k} #{hands[k]}\n")
  tot += hands[k]
end
print("total #{tot}\n")
