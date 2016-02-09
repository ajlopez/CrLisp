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

            it "get two chars" do
                source = StringSource.new "ab"
                
                char = source.nextChar
                
                char.should_not be_nil
                char.should eq('a')
                
                char = source.nextChar
                
                char.should_not be_nil
                char.should eq('b')
                
                char = source.nextChar
                char.should be_nil
            end
        end
    end
end