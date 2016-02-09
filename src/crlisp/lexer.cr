
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
                    return next_string
                end
                
                if @@separators.includes? char
                    return Token.new char.to_s, TokenType::DELIMITER
                end
 
                if  char.digit?
                    return next_integer char
                end
                    
                if char == '.' || char == '@'
                    return next_special_atom char
                end            

                if char.alpha?
                    return next_atom char
                end
                    
                if char == '\'' || char == '`' || char == ','
                    return Token.new char.to_s, TokenType::ATOM
                end

                return next_special_atom char
            end

            return nil                
        end
        
        def pushToken(token)
            @tokens.push(token)
        end
        
        private def next_string
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

        private def next_atom(firstch)
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

        private def next_special_atom(firstch)
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

        private def next_integer(firstch)
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
                    return next_real value
                end
                
                @source.push_char char
            end
            
            return Token.new value, TokenType::INTEGER
        end

        private def next_real(integral)
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
