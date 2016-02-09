
module CrLisp

    class Lexer
        @@separators = "()"

        def initialize(source)
            @source = source
            @tokens = [] of Token
        end
        
        def nextToken
            if @tokens.size > 0
                return @tokens.pop
            end
            
            char = @source.nextChar
            
            while char && char.whitespace?
                char = @source.nextChar
            end
            
            if char
                if char == '"'
                    return nextString
                end
                
                if @@separators.includes? char
                    return Token.new char.to_s, TokenType::DELIMITER
                end
 
                if  char.digit?
                    return nextInteger char
                end
                    
                if char == '.' || char == '@'
                    return nextSpecialAtom char
                end            

                if char.alpha?
                    return nextAtom char
                end
                    
                if char == '\'' || char == '`' || char == ','
                    return Token.new char.to_s, TokenType::ATOM
                end

                return nextSpecialAtom char
            end

            return nil                
        end
        
        def pushToken(token)
            @tokens.push(token)
        end
        
        private def nextString
            value = ""
            
            char = @source.nextChar
            
            while char
                if char != '"'
                    value = value + char
                    char = @source.nextChar
                else
                    break
                end
            end
            
            return Token.new value, TokenType::STRING
        end

        private def nextAtom(firstch)
            value = "" + firstch
            
            char = @source.nextChar

            while char
                if !char.whitespace? && !(@@separators.includes? char)
                    value = value + char
                    char = @source.nextChar
                else
                    @source.pushChar char
                    break
                end
            end
            
            return Token.new value, TokenType::ATOM
        end

        private def nextSpecialAtom(firstch)
            value = "" + firstch
            
            char = @source.nextChar
            
            while char
                if !char =~ /\s/ && !@@separators.includes? char
                    value = value + char
                    char = @source.nextChar
                else
                    @source.pushChar char
                    break
                end
            end
            
            return Token.new value, TokenType::ATOM
        end

        private def nextInteger(firstch)
            value = "" + firstch
            
            char = @source.nextChar
            
            while char
                if char =~ /\d/
                    value = value + char
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
