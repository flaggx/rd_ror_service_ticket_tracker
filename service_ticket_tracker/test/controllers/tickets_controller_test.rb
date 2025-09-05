require "test_helper"

class TicketsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @ticket = tickets(:one)
  end

  test "should get index" do
    get tickets_url
    assert_response :success
  end

  test "should get new" do
    get new_ticket_url
    assert_response :success
  end

  test "should create ticket" do
    assert_difference("Ticket.count") do
      post tickets_url, params: { ticket: { account_name: @ticket.account_name, assigned_to: @ticket.assigned_to, city: @ticket.city, contact_info: @ticket.contact_info, contact_person: @ticket.contact_person, issue_description: @ticket.issue_description, lease: @ticket.lease, machine_model_or_type: @ticket.machine_model_or_type, requesting_tech_name: @ticket.requesting_tech_name, under_warranty: @ticket.under_warranty } }
    end

    assert_redirected_to ticket_url(Ticket.last)
  end

  test "should show ticket" do
    get ticket_url(@ticket)
    assert_response :success
  end

  test "should get edit" do
    get edit_ticket_url(@ticket)
    assert_response :success
  end

  test "should update ticket" do
    patch ticket_url(@ticket), params: { ticket: { account_name: @ticket.account_name, assigned_to: @ticket.assigned_to, city: @ticket.city, contact_info: @ticket.contact_info, contact_person: @ticket.contact_person, issue_description: @ticket.issue_description, lease: @ticket.lease, machine_model_or_type: @ticket.machine_model_or_type, requesting_tech_name: @ticket.requesting_tech_name, under_warranty: @ticket.under_warranty } }
    assert_redirected_to ticket_url(@ticket)
  end

  test "should destroy ticket" do
    assert_difference("Ticket.count", -1) do
      delete ticket_url(@ticket)
    end

    assert_redirected_to tickets_url
  end
end
