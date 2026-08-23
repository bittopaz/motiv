require "test_helper"

class ResblockTest < ActiveSupport::TestCase
  test "matching_filters applies built year and price constraints" do
    matching = Resblock.create!(
      name: "测试小区 A",
      district: "浦东",
      built_year: 2016,
      reference_unit_price: 70_000,
      source_platform: "test"
    )
    Resblock.create!(
      name: "测试小区 B",
      district: "浦东",
      built_year: 2005,
      reference_unit_price: 50_000,
      source_platform: "test"
    )

    results = Resblock.matching_filters(built_year_min: 2014, built_year_max: 2018)

    assert_includes results, matching
    assert_equal 1, results.count
  end

  test "age_years returns years since built year" do
    resblock = Resblock.new(built_year: Time.zone.today.year - 10)

    assert_equal 10, resblock.age_years
  end
end
