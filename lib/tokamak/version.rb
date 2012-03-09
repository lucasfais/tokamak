module Tokamak
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 2
    TINY  = 2
    SUFIX = 'fais'

    STRING = [MAJOR, MINOR, TINY].join('.') + "-#{SUFIX}"

    def self.to_s
      STRING
    end
  end
end
