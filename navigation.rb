class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  # （自動販売機に投入された金額をインスタンス変数の @slot_money に代入する）
  def initialize
    # 最初の自動販売機に入っている金額は0円
    @sale = 0
    @slot_money = 0
    @coke = [{name: "coke",  price:120}] * 5
    @water = [{name: "water",  price:100}] * 5
    @red_bull = [{name: "red_bull",  price:200}] * 5

  # 在庫を追加
  end
  # 投入金額の総計を取得できる。
  def current_slot_money
    # 自動販売機に入っているお金を表示する
    @slot_money
  end
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
  # 投入は複数回できる。
  def slot_money(money)
    # 想定外のもの（１円玉や５円玉。千円札以外のお札、そもそもお金じゃないもの（数字以外のもの）など）
    # が投入された場合は、投入金額に加算せず、それをそのまま釣り銭としてユーザに出力する。
    if MONEY.include?(money)
    return false unless MONEY.include?(money)
    # 自動販売機にお金を入れる
    @slot_money += money
    end
  end
  # 払い戻し操作を行うと、投入金額の総計を釣り銭として出力する。
  def return_money
    # 返すお金の金額を表示する
    puts "釣り銭は#{@slot_money}円です"
    # 自動販売機に入っているお金を0円に戻す
    @slot_money = 0
  end
  def stock
    @stock_coke = @coke.size
  end
  def purchase
    # byebug
    if @slot_money >= 120 && @coke.size >= 1
      @sale += 120
      @coke.shift #配列から最初の１つを取り出して消す処理をかく
      @slot_money -= 120
      puts "#{@coke[0][:name]}を購入しました"
      return_money
    else
      return false
    end
  end
  def can_purchase_list_coke
    #コーラ、水、レッドブルが購入可能か判定する
    @can_coke = ""
    if @slot_money >= 120 && @coke.size >= 1
      @can_coke = "#{@coke[0][:name]}" #書き方確認
    end
  end
  def can_purchase_list_water
    #コーラ、水、レッドブルが購入可能か判定する
    @can_water = ""
    if @slot_money >= 100 && @water.size >= 1
      @can_water = "#{@water[0][:name]}" #書き方確認
    end
  end
    #購入可能な飲み物をすべて表示する
  def can_purchase_list_red_bull
    #コーラ、水、レッドブルが購入可能か判定する
    @can_red_bull = ""
    if @slot_money >= 200 && @red_bull.size >= 1
      @can_red_bull = "#{@red_bull[0][:name]}" #書き方確認
    end
  end
        #購入可能な飲み物をすべて表示する
  def can_purchase_list
    can_purchase_list_coke
    can_purchase_list_water
    can_purchase_list_red_bull
    #購入可能な飲み物をすべて表示する
    puts "購入できる飲み物:#{@can_coke} #{@can_water} #{@can_red_bull}"
  end
vm = VendingMachine.new
while true
  index = ["以下の中から行う操作を選んでください", "1:お金を入れる", "2:飲み物を買う", "3:購入できる商品を確認する", "4:購入をやめる"]
  index.each do |navigation|
    puts navigation
  end
  puts "以下の中から行う操作を選んでください"
  puts "1:お金を入れる"
  puts "2:飲み物を買う"
  puts "3:購入できる商品を確認する"
  puts "4:購入をやめる"
  number = gets.to_i
  case number
  when 1
    vm.slot_money(100)
    vm.slot_money(100)
    # 金額の選択機能が未実装です
    p vm.current_slot_money
  when 2
    vm.purchase
    break
  when 3
    vm.can_purchase_list
  when 4
    puts "購入を終了します"
    break
  else
    puts "1~4の数字を入力してください"
  end
end
end
