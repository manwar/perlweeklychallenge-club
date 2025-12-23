#! /usr/bin/crystal

def validatecoupon(codes, names, status)
  rx = Regex.new("^[0-9A-Za-z_]+$")
  dep = Set.new(["electronics", "grocery", "pharmacy", "restaurant"])
  0.upto(codes.size - 1).map { |i| !(codes[i] =~ rx).nil? && dep.includes?(names[i]) && status[i] }.to_a
end

require "spec"
describe "validatecoupon" do
  it "test_ex1" do
    validatecoupon(["A123", "B_456", "C789", "D@1", "E123"], ["electronics", "restaurant", "electronics", "pharmacy", "grocery"], [true, false, true, true, true]).should eq [true, false, true, false, true]
  end
  it "test_ex2" do
    validatecoupon(["Z_9", "AB_12", "G01", "X99", "test"], ["pharmacy", "electronics", "grocery", "electronics", "unknown"], [true, true, false, true, true]).should eq [true, true, false, true, false]
  end
  it "test_ex3" do
    validatecoupon(["_123", "123", "", "Coupon_A", "Alpha"], ["restaurant", "electronics", "electronics", "pharmacy", "grocery"], [true, true, false, true, true]).should eq [true, true, false, true, true]
  end
  it "test_ex4" do
    validatecoupon(["ITEM_1", "ITEM_2", "ITEM_3", "ITEM_4"], ["electronics", "electronics", "grocery", "grocery"], [true, true, true, true]).should eq [true, true, true, true]
  end
  it "test_ex5" do
    validatecoupon(["CAFE_X", "ELEC_100", "FOOD_1", "DRUG_A", "ELEC_99"], ["restaurant", "electronics", "grocery", "pharmacy", "electronics"], [true, true, true, true, false]).should eq [true, true, true, true, false]
  end
end
