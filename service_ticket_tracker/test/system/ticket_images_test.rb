require "application_system_test_case"

class TicketImagesTest < ApplicationSystemTestCase
  setup do
    @ticket_image = ticket_images(:one)
  end

  test "visiting the index" do
    visit ticket_images_url
    assert_selector "h1", text: "Ticket images"
  end

  test "should create ticket image" do
    visit ticket_images_url
    click_on "New ticket image"

    fill_in "Ticket", with: @ticket_image.ticket_id
    fill_in "Url", with: @ticket_image.url
    click_on "Create Ticket image"

    assert_text "Ticket image was successfully created"
    click_on "Back"
  end

  test "should update Ticket image" do
    visit ticket_image_url(@ticket_image)
    click_on "Edit this ticket image", match: :first

    fill_in "Ticket", with: @ticket_image.ticket_id
    fill_in "Url", with: @ticket_image.url
    click_on "Update Ticket image"

    assert_text "Ticket image was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket image" do
    visit ticket_image_url(@ticket_image)
    accept_confirm { click_on "Destroy this ticket image", match: :first }

    assert_text "Ticket image was successfully destroyed"
  end
end
