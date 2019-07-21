feature 'Adding a bookmark' do
  scenario 'user adds a bookmark to its bookmark manager' do
    visit('/')
    fill_in('New bookmark', :with => 'https://www.yahoo.fr/')
    fill_in('Title', :with => 'YAHOO')
    click_button('save')
    visit('/bookmarks')
    expect(page).to have_content("YAHOO")
  end

  scenario 'user enters an invalid url' do
    visit('/')
    fill_in('New bookmark', :with => 'not a real url')
    click_button('save')
    expect(current_path).to eq '/'
    expect(page).to have_content('You must submit a valid URL')
    visit('/bookmark_added')
    expect(page).not_to have_content('not a real url')
  end
end
