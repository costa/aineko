
require 'aineko'

class AinekoPad
  include Aineko

  def pubdir
    File.expand_path '~/.aineko/pub'
  end
end
