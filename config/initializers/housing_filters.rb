default_filters = {
  districts: [],
  bizcircles: [],
  built_year_min: 2014,
  built_year_max: 2018,
  reference_unit_price_min: nil,
  reference_unit_price_max: nil,
  plot_ratio_max: nil,
  green_coverage_pct_min: nil,
  management_fee_cny_max: nil,
  min_on_market_units: 1
}

local_filters_path = Rails.root.join("housing/config/filters.local.yml")
if local_filters_path.exist?
  loaded = YAML.safe_load(local_filters_path.read, permitted_classes: [ Symbol ], aliases: true) || {}
  default_filters = default_filters.merge(loaded.symbolize_keys)
end

Rails.application.config.x.housing_filters = default_filters.freeze
