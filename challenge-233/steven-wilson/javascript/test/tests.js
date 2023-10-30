describe("Challenge 233 task 1: Similar Words", function() {

    it("Example 1", function() {
        assert.equal(similarWords(["aba", "aabb", "abcd", "bac", "aabc"]), 2);
    });
    it("Example 2", function() {
        assert.equal(similarWords(["aabb", "ab", "ba"]), 3);
    });
    it("Example 3", function() {
        assert.equal(similarWords(["nba", "cba", "dba"]), 0);
    });

    it("Similar true", function() {
        assert.isTrue(compWords("aba", "aabb"));
    });
    it("Similar false", function() {
        assert.isNotTrue(compWords("abc", "aabb"));
    });

});

describe("Challenge 233 task 2: Frequency Sort", function() {

    it("Example 1", function() {
        expect(frequencySort([1, 1, 2, 2, 2, 3])).to.eql([3, 1, 1, 2, 2, 2]);
    });

    it("Example 2", function() {
        expect(frequencySort([2, 3, 1, 3, 2])).to.eql([1, 3, 3, 2, 2]);
    });

    it("Example 3", function() {
        expect(frequencySort([-1, 1, -6, 4, 5, -6, 1, 4, 1])).to.eql([5, -1, 4, 4, -6, -6, 1, 1, 1]);
    });
});
