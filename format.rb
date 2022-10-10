# frozen_string_literal: true

require 'csv'

input, output = ARGV

INPUT_HEADERS = ['Folder Name', 'Quantity', 'Trade Quantity', 'Card Name', 'Set Code', 'Set Name', 'Card Number',
                 'Condition', 'Printing', 'Language', 'Price Bought', 'Date Bought', 'LOW', 'MID', 'MARKET'].freeze
OUTPUT_HEADERS = ['Count', 'Tradelist Count', 'Name', 'Edition', 'Card Number', 'Condition', 'Language', 'Foil'].freeze

input_csv = CSV.table(input, headers: INPUT_HEADERS)[2..]

output_csv = input_csv.each_with_object([OUTPUT_HEADERS]) do |row, memo|
  count = row.fetch(:quantity)
  tradelist_count = 0
  name = row.fetch(:card_name).include?(',') ? "\"#{row.fetch(:card_name)}\"" : row.fetch(:card_name)
  edition = 'Dominaria United' # TODO
  card_number = row.fetch(:card_number)
  condition = 'Near Mint' # TODO
  language = 'English' # TODO
  foil = row.fetch(:printing) == 'Foil' ? 'foil' : nil

  memo << [count, tradelist_count, name, edition, card_number, condition, language, foil]
end

File.write(output, output_csv.map { |c| c.join(',') }.join("\n"))
