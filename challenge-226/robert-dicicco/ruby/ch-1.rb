=begin
--------------------------------------
AUTHOR: Robert DiCicco
DATE  : 2023-07-17
Challenge 226 Task 1 Shuffle String ( Ruby )
--------------------------------------
=end
strings = ["lacelengh", "rulepark"]
indices = [[3,2,0,5,4,8,6,7,1],[4,7,3,1,0,5,2,6]]

offset = 0
cnt = 0

strings.each do |str|
    ndx = indices[offset]
    puts("Input: \$string = #{str}, \@indices = #{ndx}\n");
    cnt = 0
    ln = str.length()
    letters = Hash.new
    while cnt < ln
        letter = str[cnt,1];
        x = ndx[cnt]
        letters[x] = letter
        cnt += 1
    end
    cnt = 0
    print("Output: ");
    while cnt < ln
        print(letters[cnt])
        cnt += 1
    end
    print("\n\n")
    offset += 1
end

=begin
--------------------------------------
SAMPLE OUTPUT
ruby ShuffleString.rb

Input: $string = lacelengh, @indices = [3, 2, 0, 5, 4, 8, 6, 7, 1]
Output: challenge

Input: $string = rulepark, @indices = [4, 7, 3, 1, 0, 5, 2, 6]
Output: perlraku
--------------------------------------
=end


