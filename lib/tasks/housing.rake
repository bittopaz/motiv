namespace :housing do
  desc "Import resblocks from CSV (see housing/README.md for format)"
  task :import, [ :file ] => :environment do |_task, args|
    path = args[:file]
    abort "Usage: bin/rails housing:import[path/to/resblocks.csv]" if path.blank?

    csv_path = Pathname.new(path)
    abort "File not found: #{csv_path}" unless csv_path.exist?

    require "csv"
    imported = 0

    CSV.foreach(csv_path, headers: true, header_converters: :symbol) do |row|
      attrs = row.to_h.compact_blank
      next if attrs[:name].blank? || attrs[:district].blank?

      integer_fields = %i[
        built_year reference_unit_price total_unit_count on_market_unit_count metro_walk_distance_m
      ]
      decimal_fields = %i[plot_ratio green_coverage_pct management_fee_cny]

      integer_fields.each do |field|
        attrs[field] = attrs[field].to_s.strip.presence&.to_i
      end
      decimal_fields.each do |field|
        attrs[field] = attrs[field].to_s.strip.presence&.to_d
      end

      attrs[:source_platform] ||= "manual"
      key = if attrs[:source_resblock_id].present?
        { source_platform: attrs[:source_platform], source_resblock_id: attrs[:source_resblock_id] }
      else
        { name: attrs[:name], district: attrs[:district] }
      end

      resblock = Resblock.find_or_initialize_by(key)
      resblock.assign_attributes(attrs.except(:source_platform, :source_resblock_id, :name, :district))
      resblock.name = attrs[:name]
      resblock.district = attrs[:district]
      resblock.source_platform = attrs[:source_platform]
      resblock.source_resblock_id = attrs[:source_resblock_id] if attrs[:source_resblock_id].present?
      resblock.save!
      imported += 1
    end

    puts "Imported #{imported} resblocks from #{csv_path}"
  end
end
