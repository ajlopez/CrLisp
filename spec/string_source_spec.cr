require "spec"
require "../src/crlisp"

module CrLisp
    describe StringSource do
        context "Chars" do
            it "get char" do
                source = StringSource.new "a"
                char = source.next_char
                
                char.should_not be_nil
                char.should eq('a')
            end

            it "get two chars" do
                source = StringSource.new "ab"
                
                char = source.next_char
                
                char.should_not be_nil
                char.should eq('a')
                
                char = source.next_char
                
                char.should_not be_nil
                char.should eq('b')
                
                char = source.next_char
                char.should be_nil
            end
            
            it "push and get char" do
                source = StringSource.new ""
                
                source.push_char 'a'
                
                char = source.next_char
                
                char.should_not be_nil
                char.should eq('a')
                
                char = source.next_char
                char.should be_nil
            end
        end
    end
end