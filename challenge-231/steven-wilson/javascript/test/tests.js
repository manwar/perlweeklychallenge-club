describe("Challenge 231 task 1: Min Max", function() {

    it("Example 1", function() {
        expect(pluckMinMax( [ 3 ,2 ,1 ,4 ]  )).to.eql([ 3, 2 ]);
    });
    it("Example 2", function() {
        assert.equal(pluckMinMax( [ 3, 1 ] ), -1 );
    });
    it("Example 3", function() {
        expect( pluckMinMax( [ 2, 1, 3 ] )).to.eql([ 2 ]);
    });

});

describe("Challenge 231 task 2: Senior Citizens", function() {

    it("Example 1", function() {
        assert.equal( seniorCitizens(["7868190130M7522","5303914400F9211","9273338290F4010"]), 2 );
    });

    it("Example 2", function() {
        assert.equal( seniorCitizens(["1313579440F2036","2921522980M5644"]), 0);
    });
});
