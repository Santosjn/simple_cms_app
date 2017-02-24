require 'spec_helper'

describe 'Page' do 
	it 'Should save a page to database' do 
		page = Page.new
		page.name = 'Some name'		
		page.save
		
		expect(page).not_to be_nil
    end
end 