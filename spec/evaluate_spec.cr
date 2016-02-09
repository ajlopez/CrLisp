
require "spec"
require "../src/crlisp"

module CrLisp
    it "evaluates integers" do
        evaluate(42).should eq(42)
        evaluate(0).should eq(0)
        evaluate(1).should eq(1)
        evaluate(-3).should eq(-3)
    end

    it "evaluates strings" do
        evaluate("foo").should eq("foo")
        evaluate("bar").should eq("bar")
    end

    it "evaluates characters" do
        evaluate('a').should eq('a')
        evaluate('b').should eq('b')
    end
end
