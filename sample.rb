require 'byebug'
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
  # ステップ０　お金の投入と払い戻しの例コード
  # ステップ１　扱えないお金の例コード
  # 10円玉、50円玉、100円玉、500円玉、1000円札を１つずつ投入できる。
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
    puts @slot_money
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
      @coke  = @coke.shift #配列から最初の１つを取り出して消す処理をかく
      @slot_money -= 120
    else
      return false
    end
  end
  def can_purchase_list
    #コーラ、水、レッドブルが購入可能か判定する
    @can_coke = ""
    if @slot_money >= 120 && @coke.size >= 1
      byebug
      @can_coke = "#{@coke[0][:name]}" #書き方確認
    end
    #購入可能な飲み物をすべて表示する
    puts "購入できる飲み物は#{@can_coke}です"
  end
end

vm = VendingMachine.new
p vm.slot_money(1000)
p vm.purchase
p vm.stock
p vm.can_purchase_list
