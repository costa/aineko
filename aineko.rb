
module Aineko

  class << self
    attr_accessor :_pap_loading

    def papconfig(ctx)
      @papconfcont ||= { }
      @papconfcont[_pap_loading] = ctx
    end
    def papconfigcontext
      @papconfcont[_pap_loading]
    end
  end

  def papdir(name)
    File.expand_path(name, pubdir)
  end

  def papent(name)
    File.expand_path(name+'.rb', papdir(name))
  end

  def papconf(name)
    File.expand_path('config.rb', papdir(name))
  end

  def boot
    # TODO Fix paps order + dots and stuff
    Dir.foreach(pubdir) { |pap|
      papstart(pap) if File.readable?(papent(pap)) and File.file?(papent(pap))
    }
  end

  def papstart(name)
    Aineko._pap_loading = name
    load papent(name)
    papconfrb = papconf(name)
    papconfctx = Aineko.papconfigcontext
    eval(File.read(papconfrb), papconfctx) if papconfctx and
        File.readable?(papconfrb) and File.file?(papconfrb)
    Aineko._pap_loading = nil
  end
end
