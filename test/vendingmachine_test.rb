# $ ruby test/sample_3_test.rb でテストを実行
require 'minitest/autorun'
require './vendingmachine.rb'
require './money.rb'
require './drinkholder.rb'
require './operation.rb'

class VendingmachineTest < Minitest::Test
  def test_vending_machine_new_自動販売機のインスタンスが作成できるか
    assert VendingMachine.new
  end

  def test_add_money_500_投入金額が500円になるか
    vending_machine = VendingMachine.new
    $stdin = Object.new
    def $stdin.gets
      "500"
    end
    # coin = gets.to_i の入力値を５００に設定($stdinで標準入力ができる)
    # https://docs.ruby-lang.org/ja/latest/method/Kernel/v/stdin.html
    assert_equal 500, vending_machine.add_money
  end

  def test_add_money_600_600円を投入するとお金を返却するか
    vending_machine = VendingMachine.new
    $stdin = Object.new
    def $stdin.gets
      "600"
    end
    refute vending_machine.add_money
  end

  def test_disply_buyable_購入できる飲み物を表示できるか
    # vending_machine = VendingMachine.new
    # @current_operation = Operation.new(@drink_holder)
    # assert @current_operation.can_purchase_list
  end

  def test_purchase_drink_3のレッドブルを購入できるか
  #   vending_machine = VendingMachine.new
  #   @current_operation = Operation.new(@drink_holder)
  #   $stdin = Object.new
  #   def $stdin.gets
  #     "3"
  #   end
  #   assert @current_operation.purchase
  end

  def test_total_sales_現在の売上金額を表示できるか
    # vending_machine = VendingMachine.new
    # @current_operation = Operation.new(@drink_holder)
    # $stdin = Object.new
    # def $stdin.gets
    #   "500"
    # end
    # vending_machine.add_money
    # $stdin = Object.new
    # def $stdin.gets
    #   "3"
    # end
    # vending_machine.purchase_drink
  end
end
