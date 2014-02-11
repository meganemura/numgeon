module Numgeon
  class GameScene < SKScene

    include SceneHelper

    def initWithSize(size)
      super
      self
    end

    # Called immediately after a scene is presented by a view.
    def didMoveToView(view)
      one_time(:create_contents) do
        create_scene_contents
      end
      setup_gesture_recognizer
    end

    def create_scene_contents
      self.backgroundColor = SKColor.darkGrayColor

      @queue = []
      @state = State.new
      @world = GameWorld.new(self)
      @last_updated_at = 0
      @last_update_time_interval = 0
    end

    # GestureRecognizer のセットアップ
    def setup_gesture_recognizer
      tap_recognizer = UILongPressGestureRecognizer.alloc.initWithTarget(self, action: :'long_press:')
      tap_recognizer.minimumPressDuration = LONG_PRESS_EPOCH
      self.view.addGestureRecognizer(tap_recognizer)
    end

    # Called before each frame is rendered
    def update(current_time)
      time_since_last_update = current_time - @last_updated_at
      # Handle time delta.
      # If we drop below 60fps, we still want everything to move the same distance.
      time_since_last = current_time - @last_update_time_interval
      update_with_time_since_last_update(time_since_last)
    end

    # Call from #update
    def update_with_time_since_last_update(time_since_last)
      if game_cleared? || game_over?
        transition_to_result
        return
      end
    end

    def game_cleared?
      false
    end

    def game_over?
      false
    end

    # 以下の場合にリザルト画面に移動
    #   * ゲームクリア
    #   * ゲームオーバー
    def transition_to_result
      one_time(:cleared) do
        @world.finish

        save_game

        reveal = SKTransition.flipHorizontalWithDuration(0.5 * SPEED)
        result_scene = ResultScene.alloc.initWithSize(self.size)
        self.view.presentScene(result_scene, transition: reveal)
      end
    end

    # ゲームデータのセーブ
    def save_game
      nil
    end

    # UILongPressGestureRecognizer
    def long_press(recognizer)
      touch_location  = recognizer.locationInView(recognizer.view)
      touch_location  = self.convertPointFromView(touch_location)
      touched_node    = self.nodeAtPoint(touch_location)

      case recognizer.state
      when UIGestureRecognizerStateBegan
        logging "UILongPress: UIGestureRecognizerStateBegan"
      when UIGestureRecognizerStateChanged
        logging "UILongPress: UIGestureRecognizerStateChanged"
      when UIGestureRecognizerStateEnded
        logging "UILongPress: UIGestureRecognizerStateEnded"
      end
    end

  end
end
