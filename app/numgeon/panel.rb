module Numgeon
  class Panel < Unit::Base
    REAL_SIZE = 32
    SCALE     = 3.0
    TEXTURE   = "tilesheet"

    def set_number(n)
      @label ||= SKLabelNode.labelNodeWithFontNamed("Courier").tap do |config|
        config.name = "number"
        config.fontSize = 15
        config.fontColor = SKColor.greenColor
      end

      @label.text = n.to_s
      self << @label
    end

    def reset_number
      @label = nil
    end

    def on_down
      @label.fontColor = SKColor.blueColor
    end

    def on_up
      @label.fontColor = SKColor.redColor
    end
  end
end
