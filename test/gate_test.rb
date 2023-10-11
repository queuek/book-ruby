require 'minitest/autorun'
require_relative '../lib/gate'
require_relative '../lib/ticket'

class GateTest < Minitest::Test
  def setup
    @umeda = Gate.new(:umeda)
    @juso = Gate.new(:juso)
    @mikuni = Gate.new(:mikuni)
  end

  def test_umeda_to_juso
    ticket = Ticket.new(160)
    @umeda.enter(ticket)
    assert @juso.exit(ticket)
  end

  # 順方向
  def test_umeda_to_mikuni_when_fare_is_not_enough
    ticket = Ticket.new(160)
    @umeda.enter(ticket)
    refute @mikuni.exit(ticket)
  end

  # 逆方向
  def test_mikuni_to_umeda_when_fare_is_not_enough
    ticket = Ticket.new(160)
    @mikuni.enter(ticket)
    refute @umeda.exit(ticket)
  end

  def test_umeda_to_mikuni
    ticket = Ticket.new(190)
    @umeda.enter(ticket)
    assert @mikuni.exit(ticket)
  end

  def test_juso_to_mikumi
    ticket = Ticket.new(160)
    @juso.enter(ticket)
    assert @mikuni.exit(ticket)
  end
end
