require 'tempfile'

module Jekyll
  class RMarkdownConverter < Converter
    safe :false
    priority :high

    def matches(ext)
      ext =~ /^\.(rmd|rmarkdown)$/i
    end

    def output_ext(ext)
      ".html"
    end

    def convert(content)
      f = File.new("temp.Rmd", "w")
      f.write(content)
      f.write("\n")
      f.flush

      # http://rubyquicktips.com/post/5862861056/execute-shell-commands
      content = `_plugins/knit.r temp.Rmd`
      
      if $?.exitstatus != 0
        raise "Knitting failed" 
      end
      
      content
      # File.unlink f.path
    end
  end
end