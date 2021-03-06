require 'rails_helper'

feature 'reviewing' do
  before {Restaurant.create name: 'KFC'}

  scenario 'allows users to leave a review using a form' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
  end

  scenario 'deleting a restaurant also deletes the associated review' do
    visit '/restaurants'
    click_link 'Review KFC'
    fill_in "Thoughts", with: "so so"
    select '3', from: 'Rating'
    click_button 'Leave Review'
    expect(current_path).to eq '/restaurants'
    expect(page).to have_content('so so')
    click_link 'Delete KFC'
    expect(page).to have_content 'Restaurant deleted successfully'
    expect(page).not_to have_content 'KFC'
    expect(page).not_to have_content('so so')
  end

  # scenario 'are destroyed when the associated retaurant is destroyed' do 
  #   Restaurant.create name:'KFC'
  #   delete_restaurant
  #   expect(page).not_to have_content('so so')
  # end
  #
  # def delete_restaurant
  #   visit '/restaurants'
  #   click_link 'Review KFC'
  #   fill_in "Thoughts", with: "so so"
  #   select '3', from: 'Rating'
  #   click_button 'Leave Review'
  #   visit '/restaurants'
  #   click_link 'Delete KFC'
  # end

end
