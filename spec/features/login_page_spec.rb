feature 'View index page' do
  scenario 'Index page has content' do
    visit('/')
    expect(page).to have_content('Welcome to Your Bookmark Manager')
  end
end

# As a user,
# So that I can see my bookmarks,
# I'd like to see a list of previously added bookmarks.
feature 'Viewing Bookmarks' do
  scenario 'View all the bookmarks' do
    connection = PG.connect(dbname: "bookmark_manager_test")
    connection.exec("INSERT INTO bookmarks(url, title) VALUES('https://www.google.com/', 'GOOGLE');")
    connection.exec("INSERT INTO bookmarks(url, title) VALUES('https://www.makersacademy.com', 'MAKERS');")
    connection.exec("INSERT INTO bookmarks(url, title) VALUES('https://www.destroyallsoftware.com', 'DESTROY');")
    visit('/bookmarks')
    expect(page).to have_content("GOOGLE")
    expect(page).to have_content("MAKERS")
    expect(page).to have_content("DESTROY")
  end
end
