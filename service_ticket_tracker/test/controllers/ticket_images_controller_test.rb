require "test_helper"

class TicketImagesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket_image = ticket_images(:one)
  end

  test "should get index" do
    get ticket_images_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_image_url
    assert_response :success
  end

  test "should create ticket_image" do
    assert_difference("TicketImage.count") do
      post ticket_images_url, params: { ticket_image: { ticket_id: @ticket_image.ticket_id, url: @ticket_image.url } }
    end

    assert_redirected_to ticket_image_url(TicketImage.last)
  end

  test "should show ticket_image" do
    get ticket_image_url(@ticket_image)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_image_url(@ticket_image)
    assert_response :success
  end

  test "should update ticket_image" do
    patch ticket_image_url(@ticket_image), params: { ticket_image: { ticket_id: @ticket_image.ticket_id, url: @ticket_image.url } }
    assert_redirected_to ticket_image_url(@ticket_image)
  end

  test "should destroy ticket_image" do
    assert_difference("TicketImage.count", -1) do
      delete ticket_image_url(@ticket_image)
    end

    assert_redirected_to ticket_images_url
  end
end
