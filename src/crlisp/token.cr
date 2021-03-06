
module CrLisp

    class Token
        property value : String
        property type
        
        def initialize(@value : String, @type)
        end
    end

    class TokenType
        INTEGER = 1
        REAL = 2
        STRING = 3
        ATOM = 4
        DELIMITER = 5
    end

end

