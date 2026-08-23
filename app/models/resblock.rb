# Resblock = 小区 (residential compound). Industry term used by Beike/Lianjia APIs.
class Resblock < ApplicationRecord
  SHANGHAI_DISTRICTS = [
    "黄浦", "静安", "徐汇", "长宁", "普陀", "虹口", "杨浦",
    "浦东", "闵行", "宝山", "嘉定", "松江", "青浦", "奉贤", "金山", "崇明"
  ].freeze

  validates :name, :district, presence: true
  validates :source_platform, presence: true
  validates :reference_unit_price, numericality: { greater_than: 0 }, allow_nil: true
  validates :built_year, numericality: { only_integer: true, greater_than: 1900, less_than: 2100 }, allow_nil: true
  validates :plot_ratio, numericality: { greater_than: 0 }, allow_nil: true
  validates :green_coverage_pct, numericality: { greater_than_or_equal_to: 0, less_than_or_equal_to: 100 }, allow_nil: true

  scope :ordered_for_review, -> { order(reference_unit_price: :asc, name: :asc) }

  scope :matching_filters, lambda { |filters|
    relation = all
    relation = relation.where(district: filters[:districts]) if filters[:districts].present?
    relation = relation.where(bizcircle: filters[:bizcircles]) if filters[:bizcircles].present?
    relation = relation.where(built_year: filters[:built_year_min]..) if filters[:built_year_min].present?
    relation = relation.where(built_year: ..filters[:built_year_max]) if filters[:built_year_max].present?
    relation = relation.where(reference_unit_price: filters[:reference_unit_price_min]..) if filters[:reference_unit_price_min].present?
    relation = relation.where(reference_unit_price: ..filters[:reference_unit_price_max]) if filters[:reference_unit_price_max].present?
    relation = relation.where(plot_ratio: ..filters[:plot_ratio_max]) if filters[:plot_ratio_max].present?
    relation = relation.where(green_coverage_pct: filters[:green_coverage_pct_min]..) if filters[:green_coverage_pct_min].present?
    relation = relation.where(management_fee_cny: ..filters[:management_fee_cny_max]) if filters[:management_fee_cny_max].present?
    relation = relation.where(on_market_unit_count: filters[:min_on_market_units]..) if filters[:min_on_market_units].present?
    relation
  }

  def self.default_filters
    Rails.application.config.x.housing_filters
  end

  def age_years
    return nil unless built_year

    Time.zone.today.year - built_year
  end

  def metro_commute_label
    return nil unless nearest_metro_station.present?

    distance = metro_walk_distance_m ? " (#{metro_walk_distance_m}m)" : ""
    nearest_metro_station + distance
  end
end
