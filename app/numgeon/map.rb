module Numgeon

  class Map
    class << self

      attr_reader :columns, :rows
      def size=(size)
        @columns  = (size.width  / Tile.size).to_i
        @rows     = (size.height / Tile.size).to_i
      end

      def width
        @columns * Tile.size
      end

      def height
        @rows * Tile.size
      end

      def friends
        @friends ||= []
      end

      def enemies
        @enemies ||= []
      end

      def movers
        friends + enemies
      end

      def clear!
        @friends = nil
        @enemies = nil
      end

      # Map の (x, y) に存在する Unit を返す
      def at(x, y)
        Map.movers.find {|mover| mover.x == x && mover.y == y }
      end

      # Map の (x, y) に存在する Tile を返す
      def tile_at(x, y)
        Map.tiles.find {|tile| tile.x == x && tile.y == y }
      end

      def tiles
        @tiles ||= lay_tiles
      end

      def lay_tiles
        tiles = []
        @columns.times do |column|
          @rows.times do |row|
            if (column + row) % 2 == 0
              tile = Tile.new(6, 6)
            else
              tile = Tile.new(6, 6)
              # tile = Tile.new(5, 6)
            end
            tile.locate(column, row)
            tiles << tile
          end
        end
        tiles
      end

    end
  end
end
