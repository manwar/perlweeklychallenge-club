describe("Challenge 234 task 1: Common Characters", function() {

    it("Example 1", function() {
        expect(commonCharacters("java", "javascript", "julia")).to.eql(['j', 'a']);
    });
    it("Example 2", function() {
        expect(commonCharacters("bella", "label", "roller")).to.eql(['e', 'l', 'l']);
    });
    it("Example 3", function() {
        expect(commonCharacters("cool", "lock", "cook")).to.eql(['c', 'o']);
    });

});
