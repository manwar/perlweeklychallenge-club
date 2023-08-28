describe("Challenge 230 task 1: Separate Digits", function() {

    it("Example 1", function() {
        expect(separateDigits(1, 34, 5, 6)).to.eql([1, 3, 4, 5, 6]);
    });
    it("Example 2", function() {
        expect(separateDigits(1, 24, 51, 60)).to.eql([1, 2, 4, 5, 1, 6, 0]);
    });

});

describe("Challenge 230 task 2: Count Words", function() {

    it("Example 1", function() {
        assert.equal(countWordsWithPrefix("at", "pay", "attention", "practice", "attend"), 2);
    });

    it("Example 2", function() {
        assert.equal(countWordsWithPrefix("ja", "janet", "julia", "java", "javascript"), 3);
    });
});
