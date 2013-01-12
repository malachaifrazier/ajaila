class Colors
   NOCOLOR = "\e[0m"
   RED = "\e[1;31;40m"
   GREEN = "\e[2;32;1m"
   DARKGREEN = "\e[0;32;40m"
   YELLOW = "\e[1;33;40m"
   DARKCYAN = "\e[0;36;40m"
   INFO = "\e[0;36;1m"

end
class String
   def color(color)
      return color + self + Colors::NOCOLOR
   end
end

