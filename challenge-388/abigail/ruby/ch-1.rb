#!/opt/homebrew/opt/ruby/bin/ruby

def process (n, u = 0, d = 0, prefix = "")
    if d == n then print "#{prefix} " end
    if d <  u then process(n, u, d + 1, prefix + "D") end
    if u <  n then process(n, u + 1, d, prefix + "U") end
end

ARGF . each_line do |n|
    process n . to_i
    puts ""
end
