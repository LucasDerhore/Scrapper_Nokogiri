require_relative "../lib/cher_depute.rb"

describe "Vérifier le nombre de résultats" do
  it "au minimum 10" do
    expect((get_the_deputies_infos).count).to be > 150
  end
end