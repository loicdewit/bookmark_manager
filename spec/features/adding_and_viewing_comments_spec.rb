feature 'Adding and viewing comments' do
  feature 'a user can add and then view a comment' do
    scenario 'a comment is added to a bookmark' do
      bookmark = Bookmark.add_bookmark('http://www.makersacademy.com', title: 'Makers Academy')
      visit('/bookmarks')
      first('.bookmark').click_button 'Add comment'

      expect(current_path).to eq "/bookmarks/#{bookmark.id}/comments/new"

      fill_in 'comment', with: 'this is a test comment'
      click_button 'Submit'
      
      expect(first('.bookmark')).to have_content 'this is a test comment'
    end
  end
end
