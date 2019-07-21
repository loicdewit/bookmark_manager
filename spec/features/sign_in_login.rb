def sign_in_and_login
  visit('/')
  fill_in('New bookmark', :with => 'https://www.google.com/')
  fill_in('Title', :with => 'GOOGLE')
  click_button('save')
end
