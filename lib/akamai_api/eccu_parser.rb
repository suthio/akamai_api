require 'akamai_api/eccu/tokenizer'

module AkamaiApi
  # The {ECCUParser} class is used to create a XML request file starting from a url
  #
  # @example
  #   AkamaiApi::ECCUParser.new(foo/bar/*.png).xml
  class ECCUParser

    attr_reader :tokenizer

    def initialize expression
      @tokenizer = Tokenizer.new expression
    end
  end
end
