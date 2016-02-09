module CrLisp
    class List
        @rest : List?
        
        def initialize(first, rest : List?)
            @first = first
            @rest = rest
        end
        
        def first
            @first
        end
        
        def rest
            @rest
        end
        
        def to_s
            text = "("
            
            if @first
                text = text + @first.to_s
            else
                text = text + "nil"
            end
            
            if @rest
                text = text + " " + @rest.to_s
            end
            
            text = text + ")"
            
            return text
        end
    end
end