require 'test/unit'
require 'pesel'

class PeselTest < Test::Unit::TestCase
  Valid   = %w(75120804355 74082610668 02221407563)
  Invalid = %w(75120804350 95993823492 00000000000 123)

  def test_number_and_to_s_methods
    (Valid + Invalid).each do |number|
      p = Pesel.new(number)
      assert number, p.number
      assert number, p.to_s
    end
  end

  def test_valid_method
    Valid.each do |number|
      p = Pesel.new(number)
      assert p.valid?
    end

    Invalid.each do |number|
      p = Pesel.new(number)
      assert_equal false, p.valid?
    end
  end

  def test_birth_date_method
    p = Pesel.new(Valid[0])
    assert_equal Date.parse('1975-12-08'), p.birth_date
    p = Pesel.new(Valid[1])
    assert_equal Date.parse('1974-08-26'), p.birth_date
    p = Pesel.new(Valid[2])
    assert_equal Date.parse('2002-02-14'), p.birth_date
  end

  def test_female_and_male_methods
    p = Pesel.new(Valid[0])
    assert_equal false, p.female?
    assert p.male?

    p = Pesel.new(Valid[1])
    assert p.female?
    assert_equal false, p.male?

    p = Pesel.new(Valid[2])
    assert p.female?
    assert_equal false, p.male?
  end

  def test_gender_method
    p = Pesel.new(Valid[0])
    assert_equal :male, p.gender

    p = Pesel.new(Valid[1])
    assert_equal :female, p.gender

    p = Pesel.new(Valid[2])
    assert_equal :female, p.gender
  end

  def test_methods_that_raise_exception
    Invalid.each do |number|
      p = Pesel.new(number)
      assert_raise Pesel::NumberInvalid do
        p.birth_date
      end
      assert_raise Pesel::NumberInvalid  do
        p.female?
      end
      assert_raise Pesel::NumberInvalid  do
        p.male?
      end
      assert_raise Pesel::NumberInvalid  do
        p.gender
      end
    end
  end
end
