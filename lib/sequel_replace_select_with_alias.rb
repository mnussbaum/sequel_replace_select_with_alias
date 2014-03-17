require "sequel"

module Sequel
  class Dataset
    # Returns a copy of the dataset with the select statements
    # for the given aliased columns replacing the original selects.
    # If no aliases are given, it will return the existing selection.
    # If no columns are currently selected, it will select *.
    def replace_select_with_alias(*columns, &block)
      virtual_row_columns(columns, block)
      aliased_columns = _aliased_columns(columns)
      return self if !@opts[:select] || (@opts[:select] & aliased_columns.keys).empty?

      select(*_replace_aliases(@opts[:select], aliased_columns))
    end

    def _aliased_columns(columns)
      columns.reduce({}) do |aliased_columns, column|
        case column.alias
        when nil
        when Sequel::SQL::Identifier
          aliased_columns[column.alias.value.to_sym] = column
        else
          aliased_columns[column.alias] = column
        end

        aliased_columns
      end
    end

    def _replace_aliases(selects, aliased_columns)
      selects.map { |select| aliased_columns[select] || select }
    end
  end
end
