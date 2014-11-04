require 'features/features_spec_helper'

feature "Show shop" do
  before(:each) do
    @books = FactoryGirl.create_list(:book, Paginate.books_on_page*2)
  end


  scenario "Visitor open next shop page" do
    visit shop_path

    expect(page).to have_link('2', href: shop_path(page: '2'))
    click_link('2', href: shop_path(page: '2'))
    expect(page).to have_selector('span.book-title', text: @books[Paginate.books_on_page].title)
  end

  pending 'Visitor back to home page'
end
