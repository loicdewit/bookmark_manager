
feature 'Deleting a bookmark' do
  scenario 'user deletes a bookmark from the bookmark manager' do
    visit('/')
    fill_in('New bookmark', :with => 'https://www.google.com/')
    fill_in('Title', :with => 'GOOGLE')
    click_button('save')
    visit ('/bookmarks')
    click_button('delete')
    visit('/bookmarks')
    expect(page).not_to have_content("GOOGLE")
  end
end
