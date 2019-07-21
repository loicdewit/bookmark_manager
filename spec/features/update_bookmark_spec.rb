require_relative './sign_in_login'

feature 'updating a bookmark' do
  scenario 'user updates the title of their bookmark' do
    sign_in_and_login
    new_name = 'Fav Browser'
    fill_in('update_title', with: new_name)
    click_button('update')
    visit('/bookmarks')
    expect(page).to have_content(new_name)
  end
end
