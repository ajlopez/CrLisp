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
    end
end