# irb
# require '/Users/mlkuri/workspace/vm/sample.rb'

class DrinkHolder
  def initialize
    @coke = [{name: "コーラ",  price:120}] * 5
    @water = [{name: "水",  price:100}] * 1
    @redbull = [{name: "レッドブル",  price:200}] * 5
    @drink = []
  end

  def drink_stock
    puts <<~EOS
    コーラ：#{@coke.size}本
    水：#{@water.size}本
    レッドブル：#{@redbull.size}本
    EOS
  end

  def pickup(number)
    case number
    when 1
      if @coke.size > 0
        return @coke
      end
    when 2
      if @water.size > 0
        return @water
      end
    when 3
      if @redbull.size > 0
        return @redbull
      end
    else
      return nil
    end
  end
end

class Money
  MONEY = [10, 50, 100, 500, 1000].freeze
  def self.is_valid(money)
    if MONEY.include?(money)
      return true
    end
  end
end

class Operation
  def initialize(drink_holder)
    @drink_list = drink_holder
    @slot_money = 0
    @sale = 0
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
    drink_number = gets.to_i
    @drink = self.select_drink(drink_number)
    if @drink.nil?
      puts "この商品は購入できません"
    elsif @slot_money >= @drink[0][:price]
      puts "#{@drink[0][:name]}を購入しました"
      # puts "売上金額:#{@sale}円"
      @slot_money -= @drink[0][:price]
      @sale = @drink[0][:price]
      @drink.shift
      self.return_money
      return @sale
    else
      puts "この商品は購入できません"
    end
  end

  def return_money
    puts "お釣りは#{@slot_money}円です"
  end

  def select_drink(number)
    @drink_list.pickup(number)
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

  def add_money
    puts "投入金額を入力してください(10、50、100、500、1000のいずれかの数値)"
    coin = gets.to_i
    if Money.is_valid(coin)
      @slot_money += coin
    else
      puts "想定外のものが入力されたため返却します"
      puts "#{coin}円を返却しました"
    end
    # money_num = gets.to_i
    # if !Money.is_valid(money_num)
    #   puts "想定外のものが入力されたため返却します"
    #   puts "#{money}円を返却しました"
    # end
    # @slot_money += money
  end

  def can_purchase_list
    puts "現在の投入金額：#{@slot_money}円"
    # puts "購入できる飲み物:#{self.can_purchase_coke?} #{self.can_purchase_water?} #{self.can_purchase_redbull?}"
    @drink_list.drink_stock
  end
  # def current_slot_money
  #   puts "現在の投入金額は#{@slot_money}円です"
  # end
  #
  # def slot_money(coin)
  #   puts "投入金額を入力してください(10、50、100、500、1000のいずれかの数値)"
  #   coin = gets.to_i
  #   if Money.is_valid(coin)
  #     @slot_money += coin
  #   else
  #     puts "想定外のものが入力されたため返却します"
  #     puts "#{coin}円を返却しました"
  #   end
  # end
  #
end

class VendingMachine
  def initialize
    @total_sales = 0
    @total_money = 0
    @current_operation
    @drink_holder = DrinkHolder.new
  end

  def total_sales
    puts "現在の売上金額は#{@total_sales}円です"
  end

  def add_money
    if @current_operation.nil?
      @current_operation = Operation.new(@drink_holder)
    end
    result = @current_operation.add_money
    @total_money += result
  end

  def purchase_drink
    if @current_operation.nil?
      @current_operation = Operation.new(@drink_holder)
    end
    result = @current_operation.purchase
    if result.class == Integer
      @total_sales += result
      @current_operation = nil
    else
      result
    end
  end

  def disply_buyable
    if @current_operation.nil?
      @current_operation = Operation.new(@drink_holder)
    end
    @current_operation.can_purchase_list
  end

  def exit_operation
    puts "購入を終了します"
    puts "お釣りは#{@total_money}円です"
  end

  vending_machine = VendingMachine.new
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
      vending_machine.add_money
    when 2
      vending_machine.purchase_drink
    when 3
      vending_machine.disply_buyable
    when 4
      vending_machine.total_sales
    when 5
      vending_machine.exit_operation
      break
    else
      puts "1~5の数字を入力してください"
    end
  end
end
