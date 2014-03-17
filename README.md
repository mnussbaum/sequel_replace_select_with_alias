This gem adds the `Sequel::Dataset#replace_select_with_alias` method. The
method replaces selected columns from a dataset with aliases for the same
column names. It preserves the order in which columns are already selected.

If the aliased column isn't already selected in the dataset then the method
returns the existing dataset unchanged.

This functionality is particularly useful when building up a `SELECT` statement
as the input for an `INSERT` when some columns need to be transformed (i.e.
replaced with an alias) before they are inserted.

Example usages:

    DB[:items].select(:a, :b).replace_select_with_alias(Sequel.as("1", :a))
    # SELECT '1' AS a, b FROM items

    DB[:items].replace_select_with_alias(Sequel.as("1", :a))
    # SELECT * FROM items

    DB[:items].select(:a).replace_select_with_alias(Sequel.as("1", :b))
    # SELECT a FROM items

    DB[:items].select(:a, :b).replace_select_with_alias { |o| Sequel.as("1", o.a) }
    # SELECT '1' AS a, b FROM items
