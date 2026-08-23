sample_resblocks = [
  {
    name: "金桥瑞仕花园",
    district: "浦东",
    bizcircle: "金桥",
    built_year: 2015,
    reference_unit_price: 72_000,
    plot_ratio: 2.0,
    green_coverage_pct: 35,
    management_fee_cny: 3.8,
    building_type: "板楼",
    total_unit_count: 820,
    on_market_unit_count: 18,
    address: "浦东金桥路",
    source_resblock_id: "demo-jinqiao-ruishi",
    source_platform: "demo",
    nearest_metro_station: "金桥站",
    metro_walk_distance_m: 900,
    notes: "样本数据：板楼、绿化较好，适合作为筛选演示。"
  },
  {
    name: "保利翡丽公馆",
    district: "浦东",
    bizcircle: "唐镇",
    built_year: 2016,
    reference_unit_price: 68_000,
    plot_ratio: 2.2,
    green_coverage_pct: 32,
    management_fee_cny: 4.2,
    building_type: "塔板结合",
    total_unit_count: 1100,
    on_market_unit_count: 24,
    address: "浦东唐镇",
    source_resblock_id: "demo-baoli-feili",
    source_platform: "demo",
    nearest_metro_station: "唐镇站",
    metro_walk_distance_m: 1200
  },
  {
    name: "慧芝湖花园（一二期）",
    district: "静安",
    bizcircle: "大宁",
    built_year: 2014,
    reference_unit_price: 98_000,
    plot_ratio: 2.5,
    green_coverage_pct: 38,
    management_fee_cny: 5.5,
    building_type: "板楼",
    total_unit_count: 650,
    on_market_unit_count: 12,
    address: "静安区广中西路",
    source_resblock_id: "demo-huizhihu",
    source_platform: "demo",
    nearest_metro_station: "上海马戏城站",
    metro_walk_distance_m: 700
  },
  {
    name: "徐汇臻园",
    district: "徐汇",
    bizcircle: "华东理工",
    built_year: 2017,
    reference_unit_price: 85_000,
    plot_ratio: 2.8,
    green_coverage_pct: 30,
    management_fee_cny: 4.8,
    building_type: "塔楼",
    total_unit_count: 980,
    on_market_unit_count: 15,
    address: "徐汇区老沪闵路",
    source_resblock_id: "demo-xuhui-zhenyuan",
    source_platform: "demo",
    nearest_metro_station: "华东理工大学站",
    metro_walk_distance_m: 600
  },
  {
    name: "黄山始信苑",
    district: "浦东",
    bizcircle: "金杨",
    built_year: 1999,
    reference_unit_price: 52_000,
    plot_ratio: 1.8,
    green_coverage_pct: 40,
    management_fee_cny: 1.5,
    building_type: "板楼",
    total_unit_count: 1200,
    on_market_unit_count: 45,
    address: "浦东金杨",
    source_resblock_id: "demo-huangshan-shixinyuan",
    source_platform: "demo",
    notes: "对照样本：房龄超出默认 2014–2018 区间，默认筛选应排除。"
  }
]

sample_resblocks.each do |attrs|
  Resblock.find_or_initialize_by(source_platform: attrs[:source_platform], source_resblock_id: attrs[:source_resblock_id]).tap do |resblock|
    resblock.assign_attributes(attrs)
    resblock.save!
  end
end
