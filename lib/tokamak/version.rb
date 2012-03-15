module Tokamak
  module VERSION #:nodoc:
    MAJOR = 1
    MINOR = 2
    TINY  = 3
    SUFIX = 'fais'

    STRING = [MAJOR, MINOR, TINY, SUFIX].join('.')

    def self.to_s
      STRING
    end
  end
end
