def colorize(str, beginColor, endColor = 0)
  return str unless STDOUT.isatty

  begin
    require 'Win32/Console/ANSI' if RUBY_PLATFORM =~ /win32/
  rescue LoadError
    raise 'You must gem install win32console to use colorize on Windows'
  end
    
  "\e[#{beginColor}m#{str}\e[#{endColor}m"
end

#30 Black
def black(str)
  colorize(str, "30")
end

#31 Red
def red(str)
  colorize(str, "31")
end

#31 Bright Red
def bred(str)
  colorize(str, "1;31")
end

#32 Green
def green(str)
  colorize(str, "32")
end

#32 Bright Green
def bgreen(str)
  colorize(str, "1;32")
end

#33 Yellow
def yellow(str)
  colorize(str, "33")
end

#33 Bright Yellow
def byellow(str)
  colorize(str, "1;33")
end

#34 Blue
def blue(str)
  colorize(str, "34")
end

#34 Bright Blue
def bblue(str)
  colorize(str, "1;34")
end

#35 Magenta
def magenta(str)
  colorize(str, "35")
end

#35 Bright Magenta
def bmagenta(str)
  colorize(str, "1;35")
end

#36 Cyan
def cyan(str)
  colorize(str, "36")
end

#36 Bright Cyan
def bcyan(str)
  colorize(str, "1;36")
end

#37 White
def white(str)
  colorize(str, "37")
end

#37 Bright White
def bwhite(str)
  colorize(str, "1;37")
end