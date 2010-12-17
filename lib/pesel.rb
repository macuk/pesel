class Pesel
  class NumberInvalid < Exception; end

  attr_reader :number

  def initialize(number)
    @number = number.to_s
    @digits = @number.split('')
    @valid = validate
  end

  def to_s
    number
  end

  def valid?
    @valid
  end

  def birth_date
    raise NumberInvalid unless valid?
    @birth_date
  end

  def female?
    raise NumberInvalid unless valid?
    @digits[9].to_i % 2 == 0
  end

  def male?
    raise NumberInvalid unless valid?
    @digits[9].to_i % 2 != 0
  end

  def gender
    raise NumberInvalid unless valid?
    female? ? :female : :male
  end

  private
    def validate
      has_proper_length and \
        contains_only_digits and \
        has_proper_date and \
        has_proper_control_digit
    end

    def has_proper_length
      @number.size == 11
    end

    def contains_only_digits
      @number =~ /^\d+$/
    end

    def has_proper_date
      y, m, d = @number[0..1], @number[2..3], @number[4..5]
      y, m = convert_year_and_month(y, m)
      begin
        require 'date'
        @birth_date = Date::parse("#{y}-#{m}-#{d}")
      rescue ArgumentError
        @birth_date = nil
      end
      not @birth_date.nil? 
    end

    def weights
      [1, 3, 7, 9, 1, 3, 7, 9, 1, 3, 1]
    end

    def has_proper_control_digit
      index = 0
      sum = 0
      @digits.each do |digit|
        sum += digit.to_i * weights[index]
        index += 1
      end
      sum % 10 == 0
    end

    def mods
      [
        [1800..1899, 80], 
        [2200..2299, 60], 
        [2100..2199, 40], 
        [2000..2099, 20], 
        [1900..1999, 00],
      ]
    end

    def convert_year_and_month(year, month)
      y, m = year.to_i, month.to_i
      mods.each do |range, mod|
        if m > mod
          y += range.begin
          m -= mod
          break
        end
      end
      [y, m]
    end
end
