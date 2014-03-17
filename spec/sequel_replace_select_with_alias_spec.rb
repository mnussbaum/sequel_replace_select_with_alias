require "spec_helper"

describe "Dataset#replace_select_with_alias" do
  before do
    @dataset = Sequel.mock.from(:test)
  end

  it "should do nothing if aliased columns are not present" do
    replaced_sql = @dataset.select(:a).replace_select_with_alias(Sequel.as("5", :b)).sql
    expect(replaced_sql).to eq("SELECT a FROM test")
  end

  it "should select all if no select are present" do
    replaced_sql = @dataset.replace_select_with_alias(Sequel.as("1", :a)).sql
    expect(replaced_sql).to eq("SELECT * FROM test")
  end

  it "should replace the currently selected columns with matching alias" do
    replaced_sql = @dataset.select(:a, :b).replace_select_with_alias(Sequel.as("1", :a), Sequel.as("2", :b)).sql
    expect(replaced_sql).to eq("SELECT '1' AS a, '2' AS b FROM test")
  end

  it "should leave unaliased columns untouched" do
    replaced_sql = @dataset.select(:a, :b).replace_select_with_alias(Sequel.as("1", :a)).sql
    expect(replaced_sql).to eq("SELECT '1' AS a, b FROM test")
  end

  it "should accept a block that yields a virtual row" do
    replaced_sql = @dataset.select(:a, :b).replace_select_with_alias { |o| Sequel.as("1", o.a) }.sql
    expect(replaced_sql).to eq("SELECT '1' AS a, b FROM test")
  end
end
