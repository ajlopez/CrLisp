
module CrLisp

    class Lexer
        @@separators = "()"

        def initialize(source)
            @source = source
            @tokens = [] of Token
        end
        
        def nextToken
            if @tokens.length > 0
                return @tokens.pop
            end
            
            char = @source.nextChar
            
            while char and char =~ /\s/
                char = @source.nextChar
            end
            
            if char == nil
                return nil
            end
            
            if char == '"'
                return nextString
            end
            
            if @@separators.include? char
                return Token.new char, TokenType::DELIMITER
            end

            if char =~ /\d/
                return nextInteger char
            end
            
            if char == '.' || char == '@'
                return nextSpecialAtom char
            end
            
            if char =~ /\w/
                return nextAtom char
            end
            
            if char == '\'' || char == '`' || char == ','
                return Token.new char, TokenType::ATOM
            end
            
            return nextSpecialAtom char
        end
        
        def pushToken(token)
            @tokens.push(token)
        end
        
        private def nextString
            value = ""
            
            char = @source.nextChar
            
            while char
                if char != '"'
                    value += char
                    char = @source.nextChar
                else
                    break
                end
            end
            
            return Token.new value, TokenType::STRING
        end

        private def nextAtom(firstch)
            value = firstch
            
            char = @source.nextChar
            
            while char
                if !char =~ /\s/ && !@@separators.include? char
                    value += char
                    char = @source.nextChar
                else
                    @source.pushChar char
                    break
                end
            end
            
            return Token.new value, TokenType::ATOM
        end

        private def nextSpecialAtom(firstch)
            value = firstch
            
            char = @source.nextChar
            
            while char
                if !char =~ /\s/ && !@@separators.include? char
                    value += char
                    char = @source.nextChar
                else
                    @source.pushChar char
                    break
                end
            end
            
            return Token.new value, TokenType::ATOM
        end

        private def nextInteger(firstch)
            value = firstch
            
            char = @source.nextChar
            
            while char
                if char =~ /\d/
                    value += char
                    char = @source.nextChar
                else
                    @source.pushChar char
                    break
                end
            end
            
            return Token.new value, TokenType::INTEGER
        end
    end

end
