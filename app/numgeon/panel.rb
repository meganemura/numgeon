module Numgeon
  class Panel < Unit::Base
    REAL_SIZE = 32
    SCALE     = 3.0
    TEXTURE   = "tilesheet"

    def set_number(n)
      setup_label unless @label
      @number = n
      @label.text = n.to_s
    end
    attr_reader :number

    def setup_label
      @label = SKLabelNode.labelNodeWithFontNamed("Courier").tap do |config|
        config.name = "number"
        config.fontSize = 15
        config.fontColor = SKColor.greenColor
      end
      self << @label
    end

    def reset_number
      @label = nil
    end

    def on_down
      @label.fontColor = SKColor.blueColor
    end

    def on_success
      @label.fontColor = SKColor.greenColor
    end

    def on_failed
      @label.fontColor = SKColor.redColor
    end

    def on_noop
      @label.fontColor = SKColor.greenColor
    end
  end
end
