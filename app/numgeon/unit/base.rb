module Numgeon
  module Unit
    class Base < SKSpriteNode

      REAL_SIZE = 0
      SCALE = 1.0
      TEXTURE = ""
      Z_POSITION = 0

      class << self

        attr_accessor :tile_size

        # テクスチャの (x, y) を Sprite として利用する
        def new(x, y)
          setup_once

          instance = self.spriteNodeWithTexture(partial_texture(x, y)).tap do |config|
            config.x = x
            config.y = y
            # config.anchorPoint = [0.5, 0.5] # default
            config.scale = self::SCALE
            config.zPosition = self::Z_POSITION
          end

          instance
        end

        def partial_texture(x, y)
          rect = CGRectMake(x * @w, y * @h, @w, @h)
          SKTexture.textureWithRect(rect, inTexture: @texture)
        end

        def setup_once
          unless @setup_done
            @setup_done = true
            @texture = SKTexture.textureWithImageNamed(self::TEXTURE)
            @w = self::REAL_SIZE / @texture.size.width
            @h = self::REAL_SIZE / @texture.size.height
          end
        end

        def size
          self::REAL_SIZE * self::SCALE
        end

        def anchor_point_offset
          self::REAL_SIZE * self::SCALE * 0.5
        end
      end

      attr_accessor :x, :y

      def locate(x, y)
        @x = x
        @y = y
        position = [@x, @y].to_point * self.class.size + self.class.anchor_point_offset
        self.setPosition(position)
      end

    end
  end
end
