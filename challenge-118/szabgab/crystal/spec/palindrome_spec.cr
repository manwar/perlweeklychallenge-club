require "spec"
require "../src/palindrome"

describe "Palindrome" do
  it "verify" do
    palindrome?(5).should be_true
    palindrome?(4).should be_false
    palindrome?(15).should be_true
    palindrome?(14).should be_false
    palindrome?(0).should be_true
    expect_raises(ArgumentError, "Negative number not accepted") do
      palindrome?(-1)
    end
  end
end
