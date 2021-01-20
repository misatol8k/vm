# irb
# require '/Users/mlkuri/workspace/vm/sample.rb'
class VendingMachine
  MONEY = [10, 50, 100, 500, 1000].freeze
  def initialize
    @sale = 0
    @slot_money = 0
    @coke = [{name: "コーラ",  price:120}] * 5
    @water = [{name: "水",  price:100}] * 5
    @redbull = [{name: "レッドブル",  price:200}] * 5
    @drink = []
  end
  def current_slot_money
    puts "現在の投入金額は#{@slot_money}円です"
  end
  def slot_money(money)
    if MONEY.include?(money)
      @slot_money += money
    else
      puts "想定外のものが入力されたため返却します"
      puts "#{money}円を返却しました"
    end
  end
  def return_money
    puts "お釣りは#{@slot_money}円です"
    @slot_money = 0
  end
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
    end
    if @drink == []
      puts "この商品は品切れのため購入できません"
    elsif @slot_money >= @drink[0][:price]
      @sale += @drink[0][:price]
      puts "#{@drink[0][:name]}を購入しました"
      puts "売上金額:#{@sale}円"
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
  def earnings
    puts "売上金額:#{@sale}円"
  end
  vm = VendingMachine.new
  while true
    index = ["---------------------",
             "以下の中から行う操作を選んでください",
             "1:お金を入れる",
             "2:飲み物を買う",
             "3:購入できる商品を確認する",
             "4:売上金額を確認する",
             "5:購入をやめる",
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
      vm.earnings
    when 5
      puts "購入を終了します"
      vm.return_money
      break
    else
      puts "1~5の数字を入力してください"
    end
  end
end
