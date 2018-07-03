require 'test_helper'

class ExcursionTest < ActiveSupport::TestCase

  def setup
    @excursion = excursions(:validExcursion)
    @noexcursion = excursions(:noValidExcursion)
  end

  test "excursion should be valid" do
    assert @excursion.valid?
  end

  test "excursion should not be valid" do
    assert_not @noexcursion.valid?
  end

  test "excursion name should not be valid by length" do
    @excursion.name = "n"
    assert_not @excursion.valid?
    @excursion.name = "n"*100
    assert_not @excursion.valid?
  end

  test "excursion name should not be valid by format" do
    @excursion.name = "n91238"
    assert_not @excursion.valid?
  end

  test "excursion busSpots should not be valid" do
    @excursion.busSpots = -1
    assert_not @excursion.valid?
  end

  test "excursion busSpots should be valid" do
    @excursion.busSpots = 0
    assert @excursion.valid?
  end

  test "excursion busSpots should not accept decimal values" do
    @excursion.busSpots = -3.14
    assert_not @excursion.valid?
  end

  test "excursion lunchSpots should not be valid" do
    @excursion.lunchSpots = -2
    assert_not @excursion.valid?
  end

  test "excursion lunchSpots should be valid" do
    @excursion.lunchSpots = 0
    assert @excursion.valid?
  end

  test "excursion lunchSpots should not accept decimal value" do
    @excursion.lunchSpots = 1.45
    assert_not @excursion.valid?
  end

end
