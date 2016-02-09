require "spec"
require "../src/crlisp"

module CrLisp
    describe List do
        it "create list with nil head" do
            list = List.new nil, nil
            
            list.should_not be_nil
            
            if list
                list.first.should be_nil
                list.rest.should be_nil
                list.to_s.should eq("(nil)")
            end
        end
    end
end