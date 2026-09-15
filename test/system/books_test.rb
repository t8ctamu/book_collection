require "application_system_test_case"

class BooksTest < ApplicationSystemTestCase
  setup do
    @book = books(:one)
  end

  test "visiting the index" do
    visit root_url
    assert_selector "h1", text: "Book Collection"
    assert_link "Add a book"
  end

  test "should create book" do
    visit root_url
    click_on "Add a book"
    fill_in "Title", with: "A new book"
    fill_in "Author", with: "A new author"
    fill_in "Price", with: "12.95"
    click_on "Create Book"
    assert_text "Book was successfully created"
    assert_text "A new author"
    assert_text "$12.95"
  end

  test "should update book" do
    visit book_url(@book)
    click_on "Update"
    fill_in "Title", with: "Updated title"
    click_on "Update Book"
    assert_text "Book was successfully updated"
    assert_text "Updated title"
  end

  test "should confirm before deleting book" do
    visit book_url(@book)
    click_on "Delete"
    assert_text "Are you sure you want to delete"
    click_on "Delete Book"
    assert_text "Book was successfully deleted"
    assert_current_path root_path
    assert_not Book.exists?(@book.id)
  end
end
