module Numgeon
  class GameWorld

    ENEMY_SPAWN_INTERVAL = 3

    def initialize(scene)
      @scene = scene

      # 1-9 のパネルをセットアップ
      setup_panels

      setup_hud

      # setup_sound_effect

      # setup_background_music

      setup_system
    end

    # ゲーム終了時の操作
    def finish
      self.backgroundMusicPlayer.stop
    end

    # タップされた
    def tapped(node)
      # プレイヤーが押すべき数字は最小の数値
      if node.number == numbers.min
        # 正しいノードならパネルを次の数字に進める
        current_max = numbers.max
        next_number = 0
        loop do
          next_number = current_max + rand_range(-1..5)
          break if next_number > node.number  # 自分よりも大きい数字にする
        end
        node.set_number(next_number)
        node.on_success
      else
        # 正しくないノードなら最小のものを赤色にする
        min_number = numbers.min
        @panels.each do |panel|
          if panel.number == min_number
            panel.on_failed
          end
        end
        node.on_success
      end
    end


    private

    def setup_panels
      # Panel.size = @scene.frame.size

      @panels = (1..9).map do |n|
        Panel.new(6, 6)
      end

      # GameScene にパネルを追加
      # 次のように配置する
      # 7,  8,  9,
      # 4,  5,  6,
      # 1,  2,  3,
      #
      # left, center, right
      #
      @panels.each_with_index do |panel, i|
        panel.set_number(i + 1)
        panel.locate(i % 3, i / 3)
        @scene << panel
      end
    end

    def setup_hud
      # State HUD
      @state_hud = StateHud.new("State:")
      @state_hud.position = [
        20 + @state_hud.frame.size.width / 2,
        @scene.size.height - (20 + @state_hud.frame.size.height)
      ].to_point
      @scene.addChild(@state_hud)
    end
    attr_reader :state_hud

    # pre-loading
    def setup_sound_effect
      SoundEffect.move_tiles
    end

    attr_accessor :backgroundMusicPlayer
    def setup_background_music
      error = Pointer.new(:object)
      background_music_url = NSBundle.mainBundle.URLForResource("music/desert", withExtension: "mp3")
      self.backgroundMusicPlayer = AVAudioPlayer.alloc.initWithContentsOfURL(background_music_url, error: error)
      self.backgroundMusicPlayer.numberOfLoops = -1
      self.backgroundMusicPlayer.prepareToPlay
      self.backgroundMusicPlayer.play
    end


    # ゲームシステムのセットアップ
    def setup_system
      @current_max    = 9  # 現在の最大値 (次に出現する数字はこれに 1 を足したもの)
    end

    def numbers
      @panels.map {|panel| panel.number }
    end

    def rand_range(range)
      a = range.first
      b = range.last
      a + rand(range.last)
    end

  end
end
