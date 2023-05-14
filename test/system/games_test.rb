require "application_system_test_case"

class GamesTest < ApplicationSystemTestCase
  test "Going to /new gives us a new random grid to play with" do
    visit new_url
    fill_in "word", with: "huienflggp"
    click_on "Play"
    assert_text "but"
  end
end
