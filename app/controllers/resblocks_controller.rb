class ResblocksController < ApplicationController
  before_action :set_resblock, only: :show

  def index
    @filters = filter_params
    @resblocks = Resblock.matching_filters(@filters).ordered_for_review
    @district_options = Resblock::SHANGHAI_DISTRICTS
    @bizcircle_options = Resblock.where.not(bizcircle: [ nil, "" ]).distinct.order(:bizcircle).pluck(:bizcircle)
  end

  def show
  end

  private

  def set_resblock
    @resblock = Resblock.find(params[:id])
  end

  def filter_params
    defaults = Resblock.default_filters.stringify_keys
    submitted = params.fetch(:filters, {}).permit(
      :district,
      :bizcircle,
      :built_year_min,
      :built_year_max,
      :reference_unit_price_min,
      :reference_unit_price_max,
      :plot_ratio_max,
      :green_coverage_pct_min,
      :management_fee_cny_max,
      :min_on_market_units
    ).to_h.compact_blank

    merged = defaults.merge(submitted)
    merged["districts"] = Array(merged.delete("district")).reject(&:blank?)
    merged["bizcircles"] = Array(merged.delete("bizcircle")).reject(&:blank?)
    merged.symbolize_keys
  end
end
