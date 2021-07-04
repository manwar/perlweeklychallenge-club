require "spec"
require "../src/seq"

describe "Seq" do
  it "verify" do
    seq(5).should eq(13)
    seq(10).should eq(32)
    seq(60).should eq(2223)
  end
end
