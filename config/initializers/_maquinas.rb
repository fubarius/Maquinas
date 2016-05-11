module Maquinas
  class << self
    def config
      Rails.application.config.x
    end
    def method_missing(*args, &block)
      config.send(*args, &block)
    end
  end
end
Maq = Maquinas
Maq.version = '0.1.0-dev'
Maq.build = (File.exist?("#{Rails.root}/REVISION") ? File.read("#{Rails.root}/REVSION") : `git rev-parse HEAD`).chomp
