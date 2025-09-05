require "application_system_test_case"

class TicketsTest < ApplicationSystemTestCase
  setup do
    @ticket = tickets(:one)
  end

  test "visiting the index" do
    visit tickets_url
    assert_selector "h1", text: "Tickets"
  end

  test "should create ticket" do
    visit tickets_url
    click_on "New ticket"

    fill_in "Account name", with: @ticket.account_name
    fill_in "Assigned to", with: @ticket.assigned_to
    fill_in "City", with: @ticket.city
    fill_in "Contact info", with: @ticket.contact_info
    fill_in "Contact person", with: @ticket.contact_person
    fill_in "Issue description", with: @ticket.issue_description
    check "Lease" if @ticket.lease
    fill_in "Machine model or type", with: @ticket.machine_model_or_type
    fill_in "Requesting tech name", with: @ticket.requesting_tech_name
    check "Under warranty" if @ticket.under_warranty
    click_on "Create Ticket"

    assert_text "Ticket was successfully created"
    click_on "Back"
  end

  test "should update Ticket" do
    visit ticket_url(@ticket)
    click_on "Edit this ticket", match: :first

    fill_in "Account name", with: @ticket.account_name
    fill_in "Assigned to", with: @ticket.assigned_to
    fill_in "City", with: @ticket.city
    fill_in "Contact info", with: @ticket.contact_info
    fill_in "Contact person", with: @ticket.contact_person
    fill_in "Issue description", with: @ticket.issue_description
    check "Lease" if @ticket.lease
    fill_in "Machine model or type", with: @ticket.machine_model_or_type
    fill_in "Requesting tech name", with: @ticket.requesting_tech_name
    check "Under warranty" if @ticket.under_warranty
    click_on "Update Ticket"

    assert_text "Ticket was successfully updated"
    click_on "Back"
  end

  test "should destroy Ticket" do
    visit ticket_url(@ticket)
    accept_confirm { click_on "Destroy this ticket", match: :first }

    assert_text "Ticket was successfully destroyed"
  end
end
