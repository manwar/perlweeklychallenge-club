using Lazy
find_anagrams(words) = @>> words map(frequencies) unique length

using Test

function TEST()
    @testset "Find Anagrams" begin
        @test find_anagrams(["acca", "dog", "god", "perl", "repl"]) == 3
        @test find_anagrams(["abba", "baba", "aabb", "ab", "ab"])   == 2
    end
end

TEST()
