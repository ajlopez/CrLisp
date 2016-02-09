require "spec"
require "../src/crlisp"

module CrLisp
    describe StringSource do
        context "Chars" do
            it "get char" do
                source = StringSource.new "a"
                char = source.nextChar
                
                char.should_not be_nil
                char.should eq('a')
            end
        end
    end
end