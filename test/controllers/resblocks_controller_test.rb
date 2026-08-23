require "test_helper"

class ResblocksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resblock = Resblock.create!(
      name: "控制器测试小区",
      district: "闵行",
      bizcircle: "春申",
      built_year: 2015,
      reference_unit_price: 65_000,
      plot_ratio: 2.1,
      green_coverage_pct: 33,
      on_market_unit_count: 8,
      source_platform: "test",
      source_resblock_id: "controller-demo"
    )
  end

  test "index lists resblocks matching default filters" do
    get resblocks_url

    assert_response :success
    assert_match @resblock.name, response.body
  end

  test "index filters by district" do
    get resblocks_url, params: { filters: { district: "徐汇" } }

    assert_response :success
    assert_no_match @resblock.name, response.body
  end

  test "show renders resblock details" do
    get resblock_url(@resblock)

    assert_response :success
    assert_match "控制器测试小区", response.body
    assert_match "春申", response.body
  end
end
