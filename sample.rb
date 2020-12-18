# このコードをコピペしてrubyファイルに貼り付け、そのファイルをirbでrequireして実行しましょう。
# 例
# irb
# require '/Users/mlkuri/workspace/vm/sample.rb'
# （↑のパスは、自動販売機ファイルが入っているパスを指定する）
# 初期設定（自動販売機インスタンスを作成して、vmという変数に代入する）
# vm = VendingMachine.new
# 作成した自動販売機に100円を入れる
# vm.slot_money (100)
# 作成した自動販売機に入れたお金がいくらかを確認する（表示する）
# vm.current_slot_money
# 作成した自動販売機に入れたお金を返してもらう
# vm.return_money

class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @sale = 0
    @slot_money = 0
    @coke = [{name: "コーラ",  price:120}] * 5
    @water = [{name: "水",  price:100}] * 5
    @redbull = [{name: "レッドブル",  price:200}] * 5
    @drink = []
  # 在庫を追加
  end
  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    puts "現在の投入金額は#{@slot_money}円です"
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    if MONEY.include?(money)
      @slot_money += money
    else
      puts "想定外のものが入力されたため返却します"
      puts "#{money}円を返却しました"
    # return false unless MONEY.include?(money)
    end
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "お釣りは#{@slot_money}円です"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
  # def stock
  #   @stock_coke = @coke.size
  # end
  def purchase
    index = ["---------------------",
             "以下の中から購入する商品の番号を入力してください",
             "1:コーラ",
             "2:水",
             "3:レッドブル",
             "---------------------"]
    index.each do |navigation|
      puts navigation
    end
    drink = gets.to_i
      case drink
      when 1
        puts "投入金額を入力してください(10、50、100、500、1000のいずれかの数値)"
        @drink = @coke
      when 2
        @drink = @water
      when 3
        @drink = @redbull
      else
        puts "購入可能な商品の番号を入力してください"
        @drink = [{name: "サンプル",  price:100000}]
      end
    if @slot_money >= @drink[0][:price] && @drink.size >= 1
      # 在庫０のときの回避方法が未定
      @sale += @drink[0][:price]
      puts "#{@drink[0][:name]}を購入しました"
      @slot_money -= @drink[0][:price]
      @drink.shift
    else
      puts "この商品は購入できません"
    end
  end
  def can_purchase_coke?
    if @slot_money >= 120 && @coke.size >= 1
      @coke[0][:name]
    end
  end
  def can_purchase_water?
    if @slot_money >= 100 && @water.size >= 1
      @water[0][:name]
    end
  end
  def can_purchase_redbull?
    if @slot_money >= 200 && @redbull.size >= 1
      @redbull[0][:name]
    end
  end
  def can_purchase_list
    puts "購入できる飲み物:#{self.can_purchase_coke?} #{self.can_purchase_water?} #{self.can_purchase_redbull?}"
    puts <<~EOS
    現在の投入金額：#{@slot_money}円
    コーラ：#{@coke.size}本
    水：#{@water.size}本
    レッドブル：#{@redbull.size}本
    EOS
  end
  vm = VendingMachine.new
  while true
    index = ["---------------------",
             "以下の中から行う操作を選んでください",
             "1:お金を入れる",
             "2:飲み物を買う",
             "3:購入できる商品を確認する",
             "4:購入をやめる",
             "---------------------"]
    index.each do |navigation|
      puts navigation
    end
    number = gets.to_i
    case number
    when 1
      puts "投入金額を入力してください(10、50、100、500、1000のいずれかの数値)"
      money = gets.to_i
      vm.slot_money(money)
      vm.current_slot_money
    when 2
      vm.purchase
    when 3
      vm.can_purchase_list
    when 4
      puts "購入を終了します"
      vm.return_money
      break
    else
      puts "1~4の数字を入力してください"
    end
  end
end

# vm = VendingMachine.new
# p vm.slot_money(100)
# p vm.slot_money(10)
# p vm.slot_money(10)
# vm.can_purchase_list
# vm.purchase
