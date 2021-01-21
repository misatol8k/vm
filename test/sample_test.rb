#テストコードの雛形
require 'minitest/autorun'
require './sample_2.rb'
# 別ファイルのコードをテストする場合にrequireを追加

class SampleTest < Minitest::Test
  def test_sample
    # 自動販売機のインスタンスが作成できるか？
    assert VendingMachine.new

    vm = VendingMachine.new
    drink = Drink.new
    money = Money.new
    operation = Operation.new
    # 500円を投入すると成功（お金を @slot_moneyに投入）するか？
    assert 500, money.slot_money(500)

    # 600円を投入すると失敗（お金を返却）するか？
    refute money.slot_money(600)

    # @slot_money = 500のときにコーラが購入できるか？
    assert operation.can_purchase_coke?

    # drink = gets.to_i の入力値を3に設定($stdinで標準入力ができる)
    # https://docs.ruby-lang.org/ja/latest/method/Kernel/v/stdin.html
    $stdin = Object.new
    def $stdin.gets
      "3"
    end
    # "3:レッドブル"を購入できるか？
    assert operation.purchase
  end
end
