describe("Challenge 229 task 1: Lexicographic Order", function() {

  it("0 not in order", function() {
    assert.equal( not_sorted(["abc", "xyz", "mno"]), 0 );
  });

  it("1 not in order", function() {
    assert.equal( not_sorted(["abc", "bce", "cae"]), 1 );
  });

  it("2 not in order", function() {
    assert.equal( not_sorted(["yxz", "cba", "mon"]), 2 );
  });
});

describe("Challenge 229 task 2: Two out of Three", function() {

    // https://www.chaijs.com/api/bdd/#method_eql
  it("Example 1: returns [2,4]", function() {
    expect( two_out_of_three([1, 1, 2, 4], [2, 4], [4])).to.eql([2, 4]);
  });

  it("Example 2: returns [1,2,4]", function() {
    expect( two_out_of_three([4, 1], [2, 4], [1, 2])).to.eql([1, 2, 4]);
  });
});
