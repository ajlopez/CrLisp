
module CrLisp

    class Lexer
        @@separators = "()"

        def initialize(source)
            @source = source
            @tokens = [] of Token
        end
        
        def next_token
            if @tokens.size > 0
                return @tokens.pop
            end
            
            char = @source.next_char
            
            while char && char.whitespace?
                char = @source.next_char
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
            
            char = @source.next_char
            
            while char
                if char != '"'
                    value = value + char
                    char = @source.next_char
                else
                    break
                end
            end
            
            return Token.new value, TokenType::STRING
        end

        private def nextAtom(firstch)
            value = "" + firstch
            
            char = @source.next_char

            while char
                if !char.whitespace? && !(@@separators.includes? char)
                    value = value + char
                    char = @source.next_char
                else
                    @source.push_char char
                    break
                end
            end
            
            return Token.new value, TokenType::ATOM
        end

        private def nextSpecialAtom(firstch)
            value = "" + firstch
            
            char = @source.next_char
            
            while char
                if !char =~ /\s/ && !@@separators.includes? char
                    value = value + char
                    char = @source.next_char
                else
                    @source.push_char char
                    break
                end
            end
            
            return Token.new value, TokenType::ATOM
        end

        private def nextInteger(firstch)
            value = "" + firstch
            
            char = @source.next_char
            
            while char
                if char.digit?
                    value = value + char
                    char = @source.next_char
                else
                    break
                end
            end
            
            if char
                if char == '.'
                    return nextReal value
                end
                
                @source.push_char char
            end
            
            return Token.new value, TokenType::INTEGER
        end

        private def nextReal(integral)
            value = integral + '.';
            
            char = @source.next_char
            
            while char
                if char.digit?
                    value = value + char
                    char = @source.next_char
                else
                    @source.push_char char
                    break
                end
            end
            
            return Token.new value, TokenType::REAL
        end
    end

end
