
require "spec"
require "../src/crlisp"

module CrLisp
    describe Lexer do
        context "integers" do
            it "get integer token" do
                source = StringSource.new "42"
                lexer = Lexer.new source
                token = lexer.nextToken

                token.should_not be_nil
        		if token
        	        token.type.should eq(TokenType::INTEGER)
	                token.value.should eq("42")
		        end

                lexer.nextToken().should be_nil
            end

            it "get two integer tokens" do
                source = StringSource.new "12 34"
                lexer = Lexer.new source
                
                token = lexer.nextToken

                token.should_not be_nil
        		if token
        	        token.type.should eq(TokenType::INTEGER)
	                token.value.should eq("12")
		        end
                
                token = lexer.nextToken

                token.should_not be_nil
        		if token
        	        token.type.should eq(TokenType::INTEGER)
	                token.value.should eq("34")
		        end

                lexer.nextToken().should be_nil
            end
        end
        
        context "atoms" do
            it "get atom token" do
                source = StringSource.new "atom"
                lexer = Lexer.new source
                token = lexer.nextToken

                token.should_not be_nil
        		if token
        	        token.type.should eq(TokenType::ATOM)
	                token.value.should eq("atom")
		        end

                lexer.nextToken().should be_nil
            end

            it "get atom token with spaces" do
                source = StringSource.new "  atom   "
                lexer = Lexer.new source
                token = lexer.nextToken

                token.should_not be_nil

        		if token
        	        token.type.should eq(TokenType::ATOM)
	                token.value.should eq("atom")
		        end
                
                lexer.nextToken().should be_nil
            end

            it "get two atoms" do
                source = StringSource.new "foo bar"
                lexer = Lexer.new source
                token = lexer.nextToken

                token.should_not be_nil
		        
                if token
	                token.value.should eq("foo")
        	        token.type.should eq(TokenType::ATOM)
		        end
                
                token = lexer.nextToken

                token.should_not be_nil
		        
                if token
                	token.value.should eq("bar")
                	token.type.should eq(TokenType::ATOM)
		        end

                lexer.nextToken().should be_nil
            end
        end
        
        context "delimiters" do
            it "get parenthesis" do
                source = StringSource.new "()"
                lexer = Lexer.new source

                token = lexer.nextToken

                token.should_not be_nil
		        
                if token
	                token.value.should eq("(")
        	        token.type.should eq(TokenType::DELIMITER)
		        end

                token = lexer.nextToken

                token.should_not be_nil
		
                if token
	                token.value.should eq(")")
        	        token.type.should eq(TokenType::DELIMITER)
		        end

		        lexer.nextToken().should be_nil
            end
        end
    end
end
