
module CrLisp

	class StringSource	
		def initialize(text)
			@text = text
			@position = 0
			@chars = [] of Char
		end
		
		def next_char
			if @chars.size > 0
				return @chars.pop
			end
			
			if @text.size <= @position
				return nil
			end
		
			char = @text[@position]
			@position += 1
			return char
		end
		
		def push_char(ch)
			@chars.push ch
		end
	end

end
