require 'spec_helper'

#class attributes need to be reset after each test

feature 'Guest searches for a hashtag' do
  scenario 'displays search results' do
    search_for '#rails'
    expect(current_path).to eq '/searches/rails'
    expect(page).to have_css 'li', text: /#rails/i, count: 15
  end

  scenario 'dislays known information' do
    search_fake_twitter '#rails', 5.times.map {{ text: 'I love #rails'}}
    search_for '#rails'
    expect(current_path).to eq '/searches/rails'
    expect(page).to have_css 'li', text: 'I love #rails', count: 5
  end

  scenario 'searches without a hashtag' do
    search_fake_twitter '#rails', 5.times.map {{ text: 'I love #rails'}}
    search_for 'rails'
    expect(current_path).to eq '/searches/rails'
    expect(page).to have_css 'li', text: /#rails/i, count: 5
  end

  scenario 'updates search results' do
    search_fake_twitter '#ruby', 5.times.map {{ text: 'I love #ruby'}}
    search_for '#rails'
    fill_in 'Search', with: '#ruby'
    click_on 'Submit'
    expect(current_path).to eq '/searches/ruby'
    expect(page).to have_css 'li', text: /#ruby/i, count: 5
  end

  def search_for(term)
    visit root_path
    fill_in 'Search', with: term
    click_on 'Submit'
  end

  def search_fake_twitter(term, results)
    Searcher.backend = FakeTwitter
    FakeTwitter[term] = results
  end



end
