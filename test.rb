
require 'test/unit' 
require './vending_machine'
require './user'
require './money'
require './drink'

class VMTests < Test::Unit::TestCase
  def test_vm_overview
    # vm = VendingMachine.new()
    # user = User.new(Money.new(5000))
    # deposit = user.input_amount_to_vm(Money.new(100))

    # vm.input_deposit(deposit)

    # # 자판기가 음료수 리스트를 보여준다.
    # drink = user.select_drink(Drink.new("cola",1000))

    # user.pick_up_drink(vm.return_drink(drink))

    # user.output_balance_from_vm(vm.return_balance())
  end

  def test_money_valid
    vm = VendingMachine.new()
    user = User.new(Money.new(5000))
    deposit = user.input_amount_to_vm(Money.new(5000))


    vm.input_deposit(deposit)

    # 자판기가 음료수 리스트를 보여준다.
    drink = user.select_drink(Drink.new("cola",1000))

    user.pick_up_drink(vm.return_drink(drink))

    assert_true(Money.new(100).value == Money.new(100).value)
    assert_false(Money.new(100).value == Money.new(500).value)

    money1 = Money.new(150)
    money2 = Money.new(250)
    money3 = Money.new(500)

    vm.balance_calculate()
  end
end