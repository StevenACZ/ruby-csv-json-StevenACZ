require "csv"

module MoviesCsvParser
  def parse_csv_movies(filename)
    csv_to_hash(filename)
  end

  def export_csv(movies, filename)
    hash_to_csv(filename, hash_to_normal_hash(movies))
  end

  private

  def csv_to_hash(filename)
    csv_parse = []
    CSV.foreach(filename, headers: true) do |row|
      row = row.to_hash
      row["genre"] = row["genre"].split(", ")
      row["gross"] = string_to_number(row["gross"])
      csv_parse.push(row)
    end
    csv_parse
  end

  def hash_to_csv(filename, csv_export)
    CSV.open(filename, "w", headers: csv_export.first.keys, write_headers: true) do |csv|
      csv_export.each { |row| csv << row.values }
    end
  end

  def hash_to_normal_hash(movies)
    csv_export = []
    movies.each do |row|
      row["genre"] = row["genre"].join(", ")
      row["gross"] = "$#{add_one_zero(row['gross'])}M"
      csv_export.push(row)
    end
    csv_export
  end

  def add_one_zero(item)
    if item.to_s.split(".").last.size == 1
      "#{item}0"
    else
      item
    end
  end

  def string_to_number(str_num)
    num = ""
    str_num.each_char { |char| char.match(/^[0-9|.]*$/) && num += char }
    num.to_f
  end
end
