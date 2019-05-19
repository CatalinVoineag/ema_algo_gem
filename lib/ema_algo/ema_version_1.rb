module EmaAlgo
  class EmaVersion1
    attr_reader :low_price, :high_price, :small_ema, :medium_ema, :long_ema
    private :low_price, :high_price, :small_ema, :medium_ema, :long_ema

    def initialize(low_price:, high_price:, small_ema:, medium_ema:, long_ema:)
      @low_price, @high_price, @small_ema = low_price, high_price, small_ema
      @medium_ema, @long_ema = medium_ema, long_ema
    end

    def apply
      apply_strategy
    end

    private

    def apply_strategy
      if long?
        'long'
      elsif short?
        'short'
      elsif exit_long?
        'exit_long'
      elsif exit_short?
        'exit_short'
      else
        'hold'
      end
    end

    def long?
      small_ema > medium_ema &&
        small_ema > long_ema &&
        low_price > medium_ema &&
        low_price > long_ema
    end

    def short?
      small_ema < medium_ema &&
        small_ema < long_ema &&
        high_price < medium_ema &&
        high_price < long_ema
    end

    def exit_long?
      (small_ema < medium_ema && high_price < medium_ema) ||
        (small_ema < long_ema && high_price < long_ema)
    end

    def exit_short?
      (small_ema > medium_ema && low_price > medium_ema) ||
        (small_ema > long_ema && low_price > long_ema)
    end
  end
end
