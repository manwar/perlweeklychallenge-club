describe("Challenge 228 task 1: sumUnique()", function() {

  it("2 unique elements", function() {
    assert.equal( sumUnique([2, 1, 3, 2]), 4);
  });

  it("zero unique elements", function() {
    assert.equal( sumUnique([1, 1, 1, 1]), 0);
  });

  it("all elements unique", function() {
    assert.equal( sumUnique([2, 1, 3, 4]), 10);
  });  
});


describe("Challenge 228 task 2: emptyArray()", function() {

  it("array out of order", function() {
    assert.equal( emptyArray([3, 4, 2]), 5);
  });

  it("array accending order", function() {
    assert.equal( emptyArray([1, 2, 3]), 3);
  });

  it("array empty", function() {
    assert.equal( emptyArray([]), 0);
  });  
});
