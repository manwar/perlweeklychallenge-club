#!/opt/homebrew/opt/ruby/bin/ruby

matrix = []

ARGF . each_line {
    |line|
    matrix . push (line . strip() . split(" ") . map {|x| x . to_i})
}

N = matrix . length
r = true

for i in 0 .. (N - 1) do
    row = {}
    col = {}
    for j in 0 .. (N - 1) do
        r &&= 1 <= matrix [i] [j] && matrix [i] [j] <= N
        row [matrix [i] [j]] = 1
        col [matrix [j] [i]] = 1
    end
    r &&= row . length == N && col . length == N
end

puts r ? "true" : "false"
