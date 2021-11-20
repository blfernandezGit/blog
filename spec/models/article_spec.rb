require 'rails_helper'

# RSpec.describe 'Creating Article Posts', driver: :selenium_chrome, js: true do
#     it 'saves and displays the resulting article post' do
#         visit '/articles'
#         click_on 'New Article'
#         fill_in 'Name', with: 'Jet_test_name_1'
#         fill_in 'Body', with: 'Jet_test_body_1'
#         click_on 'Save Article'
#         expect(page).to have_content ('Jet_test_name_1')
#         expect(page).to have_content ('Jet_test_body_1')
#         article_post = Article.order('id').last
#         expect(article_post.name).to eq('Jet_test_name_1')
#         expect(article_post.body).to eq('Jet_test_body_1')
#     end
# end

RSpec.describe Article, type: :model do

    let!(:article) {Article.new}
    let!(:article2) {Article.new}

    context 'Validations' do
        it '1. Is not valid without a name' do
            article.body = 'Sample body'
            article.name = nil

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:name)
        end

        it '2. Is not valid without a body' do
            article.name = 'Sample name'
            article.body = nil

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:body)
        end

        it '3. Creates a new article if attributes are valid' do
            article_count = Article.count #assume 0 initially
            article.name = "Sample name"
            article.body = "Sample body"

            article.save!
            expect(Article.count).to eq(1)
        end

        it '4. Is not valid when less than 10 characters' do
            article.name = 'Sample name'
            article.body = 'Sample'

            expect(article).to_not be_valid
            expect(article.errors).to be_present
            expect(article.errors.to_hash.keys).to include(:body)
        end

        it '5. Is not valid when name is duplicated' do
            article.name = 'Sample name'
            article.body = 'Sample body'
            article.save!

            article2.name = 'Sample name'
            article2.body = 'Sample body 2'

            expect(article2).to_not be_valid
            expect(article2.errors).to be_present
            expect(article2.errors.to_hash.keys).to include(:name)
        end
    end
end